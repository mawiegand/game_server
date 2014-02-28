require 'util'

class Fundamental::Alliance < ActiveRecord::Base  
  
  has_many   :members,   :class_name => "Fundamental::Character",     :foreign_key => "alliance_id", :inverse_of => :alliance
  has_many   :armies,    :class_name => "Military::Army",             :foreign_key => "alliance_id", :inverse_of => :alliance
  has_many   :locations, :class_name => "Map::Location",              :foreign_key => "alliance_id"
  has_many   :regions,   :class_name => "Map::Region",                :foreign_key => "alliance_id"
  has_many   :shouts,    :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id", :order => "created_at DESC"
  has_many   :fortresses,:class_name => "Settlement::Settlement",     :foreign_key => "alliance_id", :conditions => ["type_id = ?", 1]
  has_many   :victory_progresses, :class_name => "Fundamental::VictoryProgress", :foreign_key => "alliance_id", :inverse_of => :alliance, :dependent => :destroy
  has_many   :artifacts, :class_name => "Fundamental::Artifact",      :foreign_key => "alliance_id", :inverse_of => :alliance
  has_many   :leader_votes, :class_name => "Fundamental::AllianceLeaderVote", :foreign_key => "alliance_id", :inverse_of => :alliance

  has_many   :resource_effects,     :class_name => "Effect::AllianceResourceEffect",     :foreign_key => "alliance_id", :inverse_of => :alliance
  has_many   :construction_effects, :class_name => "Effect::AllianceConstructionEffect", :foreign_key => "alliance_id", :inverse_of => :alliance
  has_many   :experience_effects,   :class_name => "Effect::AllianceExperienceEffect",   :foreign_key => "alliance_id", :inverse_of => :alliance

  has_one    :ranking,   :class_name => "Ranking::AllianceRanking",   :foreign_key => "alliance_id", :inverse_of => :alliance
  has_one    :reservation, :class_name => "Fundamental::AllianceReservation", :foreign_key => "alliance_id", :inverse_of => :alliance

  belongs_to :leader,    :class_name => "Fundamental::Character",     :foreign_key => "leader_id"

  attr_accessible :name, :password, :description, :banner, :auto_join_disabled, :additional_members, :as => :owner
  attr_accessible *accessible_attributes(:owner), :tag, :leader_id,                                  :as => :creator # fields accesible during creation
  attr_accessible *accessible_attributes(:creator), :alliance_queue_alliance_research_unlock_count,  :as => :staff
  attr_accessible *accessible_attributes(:staff),                                                    :as => :admin
  
  attr_readable :id, :tag, :color, :name, :description, :banner, :leader_id, :members_count, :created_at, :updated_at, :size_bonus, :additional_members, :as => :default
  attr_readable *readable_attributes(:default), :alliance_queue_, :invitation_code, :as => :ally
  attr_readable *readable_attributes(:ally), :password, :auto_join_disabled,                         :as => :owner
  attr_readable *readable_attributes(:owner),                                                        :as => :staff
  attr_readable *readable_attributes(:staff),                                                        :as => :admin

  before_create :add_unique_invitation_code  
  
  before_save   :prevent_empty_password
  before_save   :update_size_bonus

  after_save    :propagate_tag_change
  after_save    :propagate_name_change
  after_save    :propagate_color_change
  after_save    :propagate_to_ranking
  after_save    :delete_all_leader_votes


  scope :auto_join_enabled,  where(auto_join_disabled: false)
  scope :not_full,           where(['members_count < size_bonus + ?', GameRules::Rules.the_rules.alliance_max_members])
  scope :non_empty,          where('members_count > 0')
  scope :auto_join_selectable, not_full.auto_join_enabled.non_empty

  def self.create_alliance(tag, name, leader, role = :creator)
    raise ConflictError.new("this alliance tag is already used") unless Fundamental::Alliance.find_by_tag(tag).nil?
    raise InternalServerError.new('no leader specified') if leader.nil? || leader.id.nil?
    
    alliance = Fundamental::Alliance.new({
      tag:       tag,
      name:      name,
      leader_id: leader.id,
    }, :as => role)
    
    raise InternalServerError.new('could not create alliance') unless alliance.save
    alliance.create_ranking({ alliance_tag: tag })

    # create victory progress objects for alliance according to victory types

    GameRules::Rules.the_rules.victory_types.each do |victory_type|
      alliance.victory_progresses.create({type_id: victory_type[:id]})
    end
    
    cmd = Messaging::JabberCommand.open_room(tag) 
    cmd.character_id = leader.id
    cmd.save
    
    alliance.add_character(leader)
    alliance
  end
  
  def self.select_auto_join_alliance(character)
    base_region = Map::Region.find(character.base_region_id)
    alliance = base_region.fortress.alliance.auto_joinable unless base_region.fortress.alliance.nil?
		return alliance unless alliance.nil?
    base_region.node.neighbor_nodes.each do |neighbor_node|
      alliance = neighbor_node.region.fortress.alliance.auto_joinable unless neighbor_node.region.fortress.alliance.nil?
		  return alliance unless alliance.nil?
		end
    base_region.locations.non_empty.each do |location|
      alliance = location.alliance.auto_joinable unless location.alliance.nil?
		  return alliance unless alliance.nil?
    end
    base_region.node.neighbor_nodes.each do |neighbor_node|
      neighbor_node.region.locations.non_empty.each do |location|
        alliance = location.alliance.auto_joinable unless location.alliance.nil?
		    return alliance unless alliance.nil?
      end
    end
    Fundamental::Alliance.auto_join_selectable.first
  end

  def self.tag_is_valid?(tag)
    # check if tag is not too long and if doesn't contain special chars
    tag.length < 6 && /[^A-Za-z0-9]/.match(tag).nil?
  end
  
  def auto_joinable
    return self if !auto_join_disabled and self.members.count > 0 and !self.full?
		nil
  end

  def determine_new_leader
    if self.members.count > 0
      self.leader_id = calculate_new_leader
    else
      self.leader_id = nil
    end
  end
  
  # calculate new leader with highest votes
  def calculate_new_leader
    new_leader_id = self.leader_id
    vote_results = {}
    self.leader_votes.each do |v|
      vote_results[v.candidate_id] = vote_results[v.candidate_id].nil? ? 1 : (vote_results[v.candidate_id] + 1)
      if vote_results[v.candidate_id] > (vote_results[new_leader_id] || 0)
        new_leader_id = v.candidate_id
      elsif vote_results[v.candidate_id] == (vote_results[new_leader_id] || 0)
        if v.candidate_id == self.leader_id || new_leader_id == self.leader_id # if votes are equal and one is current leader choose the current leader first 
          new_leader_id = self.leader_id
        else # if votes are equal but none is current leader, choose leader with highest score
          new_leader_id = (Fundamental::Character.find(new_leader_id).score >= v.candidate.score) ? new_leader_id : v.candidate_id
        end
      end
    end
    return new_leader_id
  end
  
  def add_character(character)
    character.alliance_tag = self.tag
    character.alliance_color = self.color
    character.alliance_id = self.id
    self.increment!(:members_count)
    character.save
    
    self.recalculate_size_bonus
    Fundamental::AllianceLeaderVote.create(alliance: self, voter: character, candidate: self.leader)
    
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
    character.alliance_color = nil
    character.alliance_id = nil
    self.decrement!(:members_count)
    character.save
    
    determine_new_leader
    
    self.save
    self.recalculate_size_bonus
    
    cmd = Messaging::JabberCommand.revoke_access(character, self.tag) 
    cmd.character_id = character.id
    cmd.save
  end
  
  def full?
    self.members.count >= self.size_max
  end
  
  def size_max
    GameRules::Rules.the_rules.alliance_max_members + self.size_bonus
  end
  
  def add_unique_invitation_code
    begin
      self.invitation_code = Util.make_random_string(16, true)
    end while !Fundamental::Alliance.find_by_invitation_code(self.invitation_code).nil?
  end
  
  def victory_progress_for_type(type_id)
    victory_progresses = self.victory_progresses.where(:type_id => type_id)
    victory_progresses.empty? ? nil : victory_progresses.first
  end
  
  def check_consistency
    check_and_apply_ranking_fortress_count
    check_and_apply_member_count
    check_and_apply_victory_progresses
    recalculate_size_bonus

    construction_bonus = recalc_construction_bonus_effect
    check_and_apply_construction_bonus_effect(construction_bonus)

    experience_bonus = recalc_experience_bonus_effect
    check_and_apply_experience_bonus_effect(experience_bonus)

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

  def recalc_construction_bonus_effect
    bonus = 0.0
    self.construction_effects.each do |effect|
      bonus += effect[:bonus] || 0.0
    end
    bonus
  end

  def check_and_apply_construction_bonus_effect(recalc)
    present = self.construction_bonus_effects

    if (present - recalc).abs > 0.000001
      logger.warn(">>> CONSTRUCTION BONUS EFFECT RECALC DIFFERS. Old: #{present} Corrected: #{recalc}.")
      self.construction_bonus_effects = recalc
    end
  end

  def recalc_experience_bonus_effect
    bonus = 0.0
    self.experience_effects.each do |effect|
      bonus += effect[:bonus] || 0.0
    end
    bonus
  end

  def check_and_apply_experience_bonus_effect(recalc)
    present = self.experience_bonus_effects

    if (present - recalc).abs > 0.000001
      logger.warn(">>> CONSTRUCTION BONUS EFFECT RECALC DIFFERS. Old: #{present} Corrected: #{recalc}.")
      self.experience_bonus_effects = recalc
    end
  end

  def add_resource_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      attribute = GameRules::Rules.the_rules.resource_types[effect[:resource_id]][:symbolic_id].to_s()+'_production_bonus_effects'
      amount = effect[:bonus]

      raise BadRequestError.new("could not find effect field when adding effect") unless self.has_attribute?(attribute)
      raise BadRequestError.new("no amount for effect given") if amount.nil?

      self[attribute] += amount
      propagate_production_bonus_changes
      self.save!
    end
  end

  def remove_resource_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      attribute = GameRules::Rules.the_rules.resource_types[effect[:resource_id]][:symbolic_id].to_s()+'_production_bonus_effects'
      amount = effect[:bonus]

      raise BadRequestError.new("could not find effect field when removing effect") unless self.has_attribute?(attribute)
      raise BadRequestError.new("no amount for effect given") if amount.nil?

      self[attribute] -= amount
      propagate_production_bonus_changes
      self.save!
    end
  end

  def add_construction_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      amount = effect[:bonus]

      raise BadRequestError.new("no amount for effect given") if amount.nil?

      self.construction_bonus_effects += amount
      propagate_construction_bonus_changes
      self.save!
    end
  end

  def remove_construction_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      amount = effect[:bonus]

      raise BadRequestError.new("no amount for effect given") if amount.nil?

      self.construction_bonus_effects -= amount
      propagate_construction_bonus_changes
      self.save!
    end
  end

  def add_experience_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      amount = effect[:bonus]

      raise BadRequestError.new("no amount for effect given") if amount.nil?

      self.experience_bonus_effects += amount
      propagate_experience_bonus_changes
      self.save!
    end
  end

  def remove_experience_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      amount = effect[:bonus]

      raise BadRequestError.new("no amount for effect given") if amount.nil?

      self.experience_bonus_effects -= amount
      propagate_experience_bonus_changes
      self.save!
    end
  end

  def recalculate_size_bonus
    new_size_bonus = 0
    self.members.each do |member|
      new_size_bonus = [new_size_bonus, member.alliance_size_bonus].max
    end
    if self.size_bonus != new_size_bonus
      self.size_bonus = new_size_bonus + self.additional_members
      self.save
    end
  end

  def color_r
    self.color.nil? ? nil : (self.color / (256 * 256) % 256).floor
  end

  def color_g
    self.color.nil? ? nil : (self.color / 256 % 256).floor
  end

  def color_b
    self.color.nil? ? nil : (self.color % 256).floor
  end

  def color_nil
    self.color.nil?
  end

  def set_color(params)
    if !params[:color_nil].nil? && params[:color_nil] == "1"
      self.color = nil
    else
      self.color = (params[:color_r].to_i || 0) * 256 * 256 + (params[:color_g].to_i || 0) * 256 + (params[:color_b].to_i || 0)
    end
  end

  private

    def propagate_production_bonus_changes
      ActiveRecord::Base.transaction(:requires_new => true) do
        GameRules::Rules.the_rules.resource_types.each do |resource_type|

          ally_attribute = resource_type[:symbolic_id].to_s + '_production_bonus_effects'
          pool_attribute = resource_type[:symbolic_id].to_s + '_production_bonus_alliance'

          unless self.changes[ally_attribute].nil?
            self.members.each do |member|
              member.resource_pool.lock!
              member.resource_pool.increment(pool_attribute, self.changes[ally_attribute][1] - self.changes[ally_attribute][0])
              member.resource_pool.propagate_bonus_changes
              member.resource_pool.save!
            end
          end
        end
      end
      true
    end

    def propagate_construction_bonus_changes
      ActiveRecord::Base.transaction(:requires_new => true) do
        unless self.changes['construction_bonus_effects'].nil?
          self.members.each do |member|
            member.lock!
            member.construction_bonus_alliance += self.changes['construction_bonus_effects'][1] - self.changes['construction_bonus_effects'][0]
            member.save!
          end
        end
      end
      true
    end

    def propagate_experience_bonus_changes
      ActiveRecord::Base.transaction(:requires_new => true) do
        unless self.changes['experience_bonus_effects'].nil?
          self.members.each do |member|
            member.lock!
            member.exp_bonus_alliance += self.changes['experience_bonus_effects'][1] - self.changes['experience_bonus_effects'][0]
            member.save!
          end
        end
      end
      true
    end

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
      GameRules::Rules.the_rules.victory_types.each do |victory_type|
        # get victory progress of alliance and condition
        progress = self.victory_progress_for_type(victory_type[:id])
        
        # create victory progress for this victory condition if not exists 
        if progress.nil?
          logger.warn(">>> VICTORY PROGRESS DOESN'T EXIST. Alliance: #{self.id} VictoryType: #{victory_type[:id]}.")
          progress = self.victory_progresses.create({
            type_id: victory_type[:id],
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
    
    def delete_all_leader_votes
      if !self.changes[:members_count].blank? && self.members_count == 0
        Fundamental::AllianceLeaderVote.delete_all(["alliance_id = ?", self.id])
      end
      true
    end
    
    def propagate_to_ranking 
      if !self.changes[:members_count].blank? && !self.ranking.nil?
        self.ranking.num_members = self.members_count
        self.ranking.save
      end
      true
    end

    def propagate_tag_change
      alliance_tag_change = self.changes[:tag]

      if !alliance_tag_change.blank?
        self.members.each do |character|
          character.alliance_tag = self.tag
          character.save
        end
        unless self.ranking.nil?
          self.ranking.alliance_tag = self.tag
          self.ranking.save
        end
      end
      true
    end

    def propagate_name_change
      alliance_name_change = self.changes[:name]

      if !alliance_name_change.blank? && !self.ranking.nil?
        self.ranking.alliance_name = self.name
        self.ranking.save
      end
      true
    end

    def propagate_color_change
      alliance_color_change = self.changes[:color]

      if !alliance_color_change.blank?
        self.members.each do |character|
          character.alliance_color = self.color
          character.save
        end
        unless self.ranking.nil?
          self.ranking.alliance_color = self.color
          self.ranking.save
        end
      end
      true
    end

    def update_size_bonus
      additional_members_change = self.changes[:additional_members]

      if !additional_members_change.blank?
        self.size_bonus += additional_members_change[1] - additional_members_change[0]
      end
    end
end
