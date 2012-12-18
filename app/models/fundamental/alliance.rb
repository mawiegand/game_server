require 'util'

class Fundamental::Alliance < ActiveRecord::Base  
  
  has_many   :members,   :class_name => "Fundamental::Character",     :foreign_key => "alliance_id", :inverse_of => :alliance
  has_many   :armies,    :class_name => "Military::Army",             :foreign_key => "alliance_id", :inverse_of => :alliance
  has_many   :locations, :class_name => "Map::Location",              :foreign_key => "alliance_id"
  has_many   :regions,   :class_name => "Map::Region",                :foreign_key => "alliance_id"
  has_many   :shouts,    :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id", :order => "created_at DESC"
  has_many   :fortresses,:class_name => "Settlement::Settlement",     :foreign_key => "alliance_id", :conditions => ["type_id = ?", 1]
  has_many   :victory_progresses, :class_name => "Fundamental::VictoryProgress", :foreign_key => "alliance_id", :inverse_of => :alliance
  
  has_one    :ranking,   :class_name => "Ranking::AllianceRanking",   :foreign_key => "alliance_id", :inverse_of => :alliance
  
  belongs_to :leader,    :class_name => "Fundamental::Character",     :foreign_key => "leader_id"

  
  attr_accessible :name, :password, :description, :banner,                                           :as => :owner
  attr_accessible *accessible_attributes(:owner), :tag, :leader_id,                                  :as => :creator # fields accesible during creation
  attr_accessible *accessible_attributes(:creator), :alliance_queue_alliance_research_unlock_count,  :as => :staff
  attr_accessible *accessible_attributes(:staff),                                                    :as => :admin
  
  attr_readable :id, :tag, :name, :description, :banner, :leader_id, :created_at, :updated_at,       :as => :default 
  attr_readable *readable_attributes(:default), :alliance_queue_, :invitation_code,                  :as => :ally 
  attr_readable *readable_attributes(:ally), :password,                                              :as => :owner
  attr_readable *readable_attributes(:owner),                                                        :as => :staff
  attr_readable *readable_attributes(:staff),                                                        :as => :admin

  
  before_create :add_unique_invitation_code  
  
  before_save   :prevent_empty_password
  
  after_save    :propagate_to_ranking

  
  def self.create_alliance(tag, name, leader, role = :creator)
    raise ConflictError.new("this alliance tag is already used") unless Fundamental::Alliance.find_by_tag(tag).nil?
    raise InternalServerError.new('no leader specified') if leader.nil? || leader.id.nil?
    
    alliance = Fundamental::Alliance.new({
      tag:       tag,
      name:      name,
      leader_id: leader.id,
    }, :as => role);
    
    raise InternalServerError.new('could not create alliance') unless alliance.save
    alliance.create_ranking({ alliance_tag: tag })

    # get victory conditions form rules
    victory_types = [0]
    victory_types.each do |type|
      alliance.victory_progresses.create({ victory_type: type })
    end
    
    cmd = Messaging::JabberCommand.open_room(tag) 
    cmd.character_id = leader.id
    cmd.save
    
    alliance.add_character(leader)
    return alliance
  end
  
  def determine_new_leader
    if self.members.count > 0
      self.leader_id = self.members.first.id
    else
      self.leader_id = nil
    end
  end
  
  def add_character(character)
    character.alliance_tag = self.tag
    character.alliance_id = self.id
    self.increment!(:members_count)
    character.save
    
    cmd = Messaging::JabberCommand.grant_access(character, self.tag) 
    cmd.character_id = character.id
    cmd.save
  end
  
  def kick_character(character, kicking_character)
    return false unless kicking_character.alliance_leader?
    remove_character(character)
    Messaging::Message.generate_kicked_from_alliance_message(character, kicking_character)
  end
  
  def remove_character(character)
    return false unless character.alliance_id == self.id 
    character.alliance_tag = nil
    character.alliance_id = nil
    self.decrement!(:members_count)
    character.save
    
    if self.leader_id == character.id
      determine_new_leader
    end
    self.save
    
    cmd = Messaging::JabberCommand.revoke_access(character, self.tag) 
    cmd.character_id = character.id
    cmd.save
  end
  
  def full?
    self.members.count >= GameRules::Rules.the_rules.alliance_max_members
  end
  
  def add_unique_invitation_code
    begin
      self.invitation_code = Util.make_random_string(16, true)
    end while !Fundamental::Alliance.find_by_invitation_code(self.invitation_code).nil?
  end
  
  def victory_progress_for_type(victory_type)
    victory_progresses = self.victory_progresses.where(:victory_type => victory_type)
    victory_progresses.empty? ? nil : victory_progresses.first
  end
  
  def check_consistency
    check_and_apply_ranking_fortress_count
    check_and_apply_member_count
    check_and_apply_victory_progresses

    if self.changed?
      logger.info(">>> SAVING ALLIANCE AFTER DETECTING ERRORS.")
      self.save
    elsif self.ranking.changed?
      logger.info(">>> SAVING ALLIANCE RANKING AFTER DETECTING ERRORS.")
      self.ranking.save
    else
      logger.info(">>> ALLIANCE OK.")
    end

    true      
  end
  
  def recalc_victory_progress_for_type(type)
    progress = self.victory_progress_for_type(type)
    progress.apply_victory_progress_for_type(type) unless progress.nil?
  end
  
  private
  
    def check_and_apply_ranking_fortress_count
      if !self.ranking.nil? && self.ranking.num_fortress != self.fortresses.count
        logger.warn(">>> RANKING FORTRESS COUNT RECALC DIFFERS. Old: #{self.ranking.num_fortress} Corrected: #{self.fortresses.count}.")
        self.ranking.num_fortress = self.fortresses.count
      end
    end
  
    def check_and_apply_member_count
      if self.members_count != self.members.count 
        logger.warn(">>> MEMBER COUNT RECALC DIFFERS. Old: #{self.members_count} Corrected: #{self.members.count}.")
        self.members_count = self.members.count
      end
    end
      
    def check_and_apply_victory_progresses
      # TODO get victory conditions form rules
      victory_types = [Fundamental::VictoryProgress::VICTORY_TYPE_DOMINATION]
      
      victory_types.each do |type|
        # get victory progress of alliance and condition
        progress = self.victory_progress_for_type(type)
        
        # create victory progress for this victory condition if not exists 
        if progress.nil?
          logger.warn(">>> VICTORY PROGRESS DOESN'T EXIST. Alliance: #{self.id} VictoryType: #{type}.")
          progress = self.victory_progresses.create({
            victory_type: type,
          })
        end

        # calculate progress according to condition
        fulfillment_count = progress.recalc_fulfillment_count
        if fulfillment_count != progress.fulfillment_count
          logger.warn(">>> FULFILLMENT COUNT RECALC DIFFERS. Old: #{progress.fulfillment_count} Corrected: #{fulfillment_count}.")
          progress.fulfillment_count = fulfillment_count
          progress.save
        end
      end
    end
      
    def prevent_empty_password 
      if self.password.nil?
        self.password = random_string(4)
      end
      true
    end
  
    def random_string(len = 4)
      chars = ('a'..'z').to_a + ('A'..'Z').to_a
      (0..(len-1)).collect { chars[Kernel.rand(chars.length)] }.join
    end 
    
    def propagate_to_ranking 
      if !self.changes[:members_count].blank? && !self.ranking.nil?
        self.ranking.num_members = self.members_count
        self.ranking.save
      end
    end
    
  
end
