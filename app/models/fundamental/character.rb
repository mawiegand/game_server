class Fundamental::Character < ActiveRecord::Base

  validates :identifier,  :uniqueness   => { :case_sensitive => true, :allow_blank => false }

  belongs_to :alliance,        :class_name => "Fundamental::Alliance",      :foreign_key => "alliance_id",  :inverse_of => :members
  
  has_one  :resource_pool,     :class_name => "Fundamental::ResourcePool",  :foreign_key => "character_id", :inverse_of => :owner
  has_one  :ranking,           :class_name => "Ranking::CharacterRanking",  :foreign_key => "character_id", :inverse_of => :character
  has_one  :home_location,     :class_name => "Map::Location",              :foreign_key => "owner_id",     :conditions => "settlement_type_id=2"   # in development there might be more than one!!!
  has_one  :tutorial_state,    :class_name => "Tutorial::State",            :foreign_key => "character_id", :inverse_of => :owner
  has_one  :settings,          :class_name => "Fundamental::Setting",       :foreign_key => "character_id", :inverse_of => :owner
  
  has_one  :inbox,             :class_name => "Messaging::Inbox",           :foreign_key => "owner_id",     :inverse_of => :owner
  has_one  :outbox,            :class_name => "Messaging::Outbox",          :foreign_key => "owner_id",     :inverse_of => :owner
  has_one  :archive,           :class_name => "Messaging::Archive",         :foreign_key => "owner_id",     :inverse_of => :owner

  has_many :armies,            :class_name => "Military::Army",             :foreign_key => "owner_id",     :inverse_of => :owner
  has_many :locations,         :class_name => "Map::Location",              :foreign_key => "owner_id"
  has_many :regions,           :class_name => "Map::Region",                :foreign_key => "owner_id"
  has_many :alliance_shouts,   :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id"
  has_many :shop_transactions, :class_name => "Shop::Transaction",          :foreign_key => "character_id"
  has_many :settlements,       :class_name => "Settlement::Settlement",     :foreign_key => "owner_id"
  has_many :fortresses,        :class_name => "Settlement::Settlement",     :foreign_key => "owner_id",     :conditions => ["type_id = ?", Settlement::Settlement::TYPE_FORTESS]
  has_many :outposts,          :class_name => "Settlement::Settlement",     :foreign_key => "owner_id",     :conditions => ["type_id = ?", Settlement::Settlement::TYPE_OUTPOST]

  has_many :leads_battle_factions, :class_name => "Military::BattleFaction",  :foreign_key => "leader_id", :inverse_of => :leader

  before_save :sync_alliance_tag
  after_save  :propagate_alliance_membership_changes
  after_save  :propagate_name_changes
  after_save  :propagate_score_changes
  after_save  :propagate_fortress_count_changes
  

  @identifier_regex = /[a-z]{16}/i 
  
  def self.find_by_id_or_identifier(user_identifier)
    
    identity = Fundamental::Character.find_by_id(user_identifier) if Fundamental::Character.valid_id?(user_identifier)
    identity = Fundamental::Character.find_by_identifier(user_identifier) if identity.nil? && Fundamental::Character.valid_identifier?(user_identifier)
    
    return identity
  end
  
  def self.find_by_name_case_insensitive(name)  
    Fundamental::Character.find(:first, :conditions => [ "lower(name) = ?", name.downcase ])
  end
  
  def self.valid_identifier?(identifier)
    identifier.index(@identifier_regex) != nil
  end
  
  def self.valid_id?(id)
    id.index(/^[1-9]\d*$/) != nil
  end
  
  def self.update_all_conversions
    Fundamental::Character.find(:all).each do |character|
      character.update_conversion_state
      character.save
    end
  end
  
  def update_last_request_at
    if self.last_request_at.nil? || self.last_request_at + 1.minutes < Time.now  
      self.update_column(:last_request_at, Time.now)  # change timestamp without triggering before / after handlers, without update updated_at
    end
  end  
  
  def online?
    !self.last_request_at.nil? && self.last_request_at + 2.minutes > Time.now
  end
  
  def offline?
    !self.online?
  end  
  
  def self.create_new_character(identifier, name, start_resource_modificator, npc=false)
    character = Fundamental::Character.new({
      identifier: identifier,
      name: name,
      npc:  npc,
    });
    
    if !character.save
      raise InternalServerError.new('Could not create new character.') 
    end

    character.create_resource_pool
    character.resource_pool.fill_with_start_resources_transaction(start_resource_modificator)
    
    raise InternalServerError.new('Could not save the base of the character.')  if !character.save

    if !npc
      character.create_ranking({
        character_name: name,
      });

      location = Map::Location.find_empty
      if !location || !character.claim_location(location)
        character.destroy
        raise InternalServerError.new('Could not claim an empty location.')
      end

      Settlement::Settlement.create_settlement_at_location(location, 2, character)  # 2: home base
        
      character.base_location_id = location.id
      character.base_region_id = location.region_id
      character.base_node_id = location.region.node_id
    end
    
    if !character.save
      raise InternalServerError.new('Could not save the base of the character.')
    end
    
    if !npc
      character.create_inbox
      character.create_outbox
      character.create_archive
      
      Messaging::Message.create_welcome_message(character)
      
      character.create_tutorial_state
      character.tutorial_state.create_start_quest_state     
      
      cmd = Messaging::JabberCommand.grant_access(character, 'global') 
      cmd.character_id = character.id
      cmd.save
    end
    
    return character 
  end
  
  def change_name_transaction(name)
    raise ConflictError.new("this name is already used by someone else") unless Fundamental::Character.find_by_name_case_insensitive(name).nil?
    
    freeChange = (self.name_change_count || 0) < 1 
    
    if !freeChange && !self.resource_pool.have_at_least_resources({Fundamental::ResourcePool::RESOURCE_ID_CASH => 20})
      raise ForbiddenError.new "character does not have enough resources to pay for the name change."
    end
    
    self.name = name
    self.increment(:name_change_count)

    raise InternalServerError.new 'Could not save new name.' unless self.save 
    
    if (self.name_change_count || 0) > 0 
        self.resource_pool.remove_resources_transaction({Fundamental::ResourcePool::RESOURCE_ID_CASH => 20})
    end
    
    return self
  end
  
  # should claim a location in a thread-safe way.... (e.g. check, that owner hasn't changed)
  def claim_location(location)
    # here block location, in case it's not yet blocked.  blocked lactions must be ignored by find_empty
    return true
  end
    
  
  def is_enemy_of?(opponent)
    return !self.is_neutral? && !opponent.is_neutral? && self.alliance != opponent.alliance  
  end
  
  def is_neutral?
    return self.alliance.nil?    
  end

  def is_ally_of?(other)
    return !self.alliance.nil? && !other.alliance.nil? && (self.alliance.id == other.alliance.id)
  end
  
  def lives_in_region?(region)
    return !self.locations.where("region_id = ?", region.id).empty?
  end
  
  def right_of_way_at(location)
    if location.right_of_way == 0          # all
      return true
    elsif location.right_of_way == 1       # no_enemies
      return self.lives_in_region?(location.region) || !self.is_enemy_of?(location.owner)
    elsif location.right_of_way == 2       # no_neutrals
      return self.lives_in_region?(location.region) || !self.is_enemy_of?(location.owner) && !self.is_neutral?  
    elsif location.right_of_way == 3       # no_residents
      return !self.is_enemy_of?(location.owner) && !self.is_neutral? && self.lives_in_region?(location.region)
    else                                   # forgotten anyone?
      return false
    end
  end  
  
  def name_and_ally_tag
    self.alliance_tag.nil? ? self.name : self.name + ' | ' + self.alliance_tag
  end
  
  def paying_user?
    self.shop_transactions.where(['state = ?', Shop::Transaction::STATE_CLOSED]).count > 0
  end
  
  def long_term?
    active? && self.score > 200 && self.login_count > 40 && self.last_login_at-20.days > self.created_at 
  end
  
  def active?
    !self.score.nil? && !self.login_count.nil? && self.score > 50 && self.login_count > 10 && self.last_login_at-5.days > self.created_at 
  end
  
  def logged_in_two_days?
    login_count >= 2 && self.last_login_at-1.days > self.created_at 
  end
  
  def logged_in_once?
    login_count >= 1 
  end  
  
  def update_conversion_state
    return   if self.max_conversion_state == "paying"   # nothing to do, this is the highest state
    if paying_user?
      self.max_conversion_state = "paying"
      return 
    end 
    return   if self.max_conversion_state == "long_term"
    if long_term?
      self.max_conversion_state = "long_term"
      return 
    end 
    return   if self.max_conversion_state == "active"
    if active?
      self.max_conversion_state = "active"
      return 
    end 
    return   if self.max_conversion_state == "logged_in_two_days"
    if logged_in_two_days?
      self.max_conversion_state = "logged_in_two_days"
      return 
    end 
    return   if self.max_conversion_state == "logged_in_once"
    self.max_conversion_state = "logged_in_once"
  end
  
  # ##########################################################################
  #
  #   Alliance related stuff
  #
  # ##########################################################################
  
  def leave_alliance(alliance)
    alliance.add_character(self)
  end
  
  def join_alliance(alliance)
    alliance.remove_character(self)
  end
  
  def sync_alliance_tag
    alliance_change = self.changes[:alliance_id]
    if !alliance_change.blank? && !self.alliance.nil?
      self.alliance_tag = self.alliance.tag
    end
  end

  # Function for propagating change of alliance membership to redundant fields.
  # This uses update_all direct querries because the Rails way of looping
  # through models (selecting, instantiating, saving) would potentially take
  # too long (there might be several hundreds of settlements, locations and
  # armies involved).
  def propagate_alliance_membership_changes
    alliance_change     = self.changes[:alliance_id]
    alliance_tag_change = self.changes[:alliance_tag]    
    
    redundancies = [
      { :model => Map::Location,             :field => :owner_id },
      { :model => Map::Region,               :field => :owner_id },
      { :model => Military::Army,            :field => :owner_id },
      { :model => Settlement::Settlement,    :field => :owner_id },
      { :model => Ranking::CharacterRanking, :field => :character_id, :handlers_needed => true },
    ]
    
    if !alliance_change.blank? || !alliance_tag_change.blank?
      set_clause = { }
      set_clause[:alliance_id]  = alliance_change[1]        unless alliance_change.nil?
      set_clause[:alliance_tag] = alliance_tag_change[1]    unless alliance_tag_change.nil?
            
      redundancies.each do |entry| 
        if !entry[:handlers_needed].nil? && entry[:handlers_needed] == true
          entry[:model].where(entry[:field] => self.id).each do |item|
            item.alliance_id  = alliance_change[1]          unless alliance_change.nil?
            item.alliance_tag = alliance_tag_change[1]      unless alliance_tag_change.nil?
            item.save
          end
        else
          where_clause = ["#{ entry[:field].to_s } = ?", self.id]
          entry[:model].update_all(set_clause, where_clause) 
        end
      end
    end
    true
  end
  
  # Function for propagating change of character name to redundant fields.
  # This uses update_all direct querries because the Rails way of looping
  # through models (selecting, instantiating, saving) would potentially take
  # too long (there might be several hundreds of settlements, locations and
  # armies involved).
  def propagate_name_changes
    name_change     = self.changes[:name]
    
    redundancies = [
      { :model => Map::Location,             :field => :owner_id },
      { :model => Map::Region,               :field => :owner_id },
      { :model => Military::Army,            :field => :owner_id },      
      { :model => Ranking::CharacterRanking, :field => :character_id, :handlers_needed => true, :name_field => :character_name },
    ]
    
    if !name_change.blank? 
      
      redundancies.each do |entry| 
        set_clause = { }
        set_clause[entry[:name_field] || :owner_name]  = name_change[1]    

        if !entry[:handlers_needed].nil? && entry[:handlers_needed] == true
          entry[:model].where(entry[:field] => self.id).each do |item|
            item[entry[:name_field] || :owner_name]  = name_change[1]         
            item.save
          end
        else
          where_clause = ["#{ entry[:field].to_s } = ?", self.id]
          entry[:model].update_all(set_clause, where_clause) 
        end
      end
    end
    true
  end
  
  def propagate_score_changes
    score_change = self.changes[:score]
    if !score_change.nil?
      if !self.ranking.nil?
        self.ranking.overall_score = score_change[1]
        self.ranking.save
      end
    end
    true
  end

  def propagate_fortress_count_changes
    fortress_count_change = self.changes[:fortress_count]
    if !fortress_count_change.nil?
      if !self.ranking.nil?
        self.ranking.num_fortress = (self.ranking.num_fortress || 0) + (fortress_count_change[1] || 0) - (fortress_count_change[0] || 0)
        self.ranking.save
      end
    end
    true
  end
  
  
end


