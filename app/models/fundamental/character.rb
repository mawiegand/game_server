# encoding: utf-8

require 'identity_provider/access'

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
  has_many :shop_transactions, :class_name => "Shop::Transaction",          :foreign_key => "character_id", :inverse_of => :character
  has_many :settlements,       :class_name => "Settlement::Settlement",     :foreign_key => "owner_id",     :inverse_of => :owner
  has_many :fortresses,        :class_name => "Settlement::Settlement",     :foreign_key => "owner_id",     :conditions => ["type_id = ?", Settlement::Settlement::TYPE_FORTESS]
  has_many :outposts,          :class_name => "Settlement::Settlement",     :foreign_key => "owner_id",     :conditions => ["type_id = ?", Settlement::Settlement::TYPE_OUTPOST]

  has_many :leads_battle_factions, :class_name => "Military::BattleFaction",  :foreign_key => "leader_id", :inverse_of => :leader

  attr_readable :id, :identifier, :name, :lvel, :exp, :att, :def, :wins, :losses, :health_max, :health_present, :health_updated_at, :alliance_id, :alliance_tag, :base_location_id, :base_region_id, :created_at, :updated_at, :base_node_id, :score, :npc, :fortress_count, :mundane_rank, :sacred_rank, :gender, :banned,      :as => :default 
  attr_readable *readable_attributes(:default),                                                                                :as => :ally 
  attr_readable *readable_attributes(:ally),  :premium_account, :locked, :locked_by, :locked_at, :character_unlock_, :skill_points, :premium_expiration, :character_queue_, :name_change_count, :login_count, :last_login_at, :settlement_points_total, :settlement_points_used, :gender_change_count, :ban_reason, :ban_ended_at,       :as => :owner
  attr_readable *readable_attributes(:owner), :last_request_at, :max_conversion_state, :reached_game, :credits_spent_total,    :as => :staff
  attr_readable *readable_attributes(:staff),                                                                                  :as => :admin

  before_save :sync_alliance_tag
  before_save :update_mundane_rank
  
  after_save  :propagate_alliance_membership_changes
  after_save  :propagate_name_changes
  after_save  :propagate_score_changes
  after_save  :propagate_fortress_count_changes
  
  after_commit :check_consistency_sometimes
  
  scope :non_npc,    where(['(npc IS NULL OR npc = ?)', false])
  scope :non_banned, where(['(banned IS NULL OR banned = ?)', false])


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
  
  def self.update_all_credits_spent
    Fundamental::Character.find(:all).each do |character|
      character.update_credits_spent
      character.update_gross
      character.save
    end
  end  
  
  def update_last_request_at
    if self.last_request_at.nil? || self.last_request_at + 1.minutes < Time.now  
      self.update_column(:last_request_at, Time.now)  # change timestamp without triggering before / after handlers, without update updated_at
    end
  end  
  
  def redeem_startup_gift(gift_list)
    list = ActiveSupport::JSON.decode(gift_list)
      logger.info "REDEEM RESOURCE GIFT FOR CHARACTER #{self.identifier}: #{ list.inspect }"
    (list || []).each do |resource_gift|    # nothing else allowed at present
      self.resource_pool.add_resource_atomically(resource_gift['resource_type_id'].to_i, resource_gift['amount'].to_f)
    end
  end
    
  
  def can_create_alliance?
    !character_unlock_alliance_creation_count.blank? && character_unlock_alliance_creation_count >= 1
  end
  
  def alliance_leader?
    !self.alliance.nil? && self.alliance.leader_id == self.id
  end

  
  def online?
    !self.last_request_at.nil? && self.last_request_at + 2.minutes > Time.now
  end
  
  def offline?
    !self.online?
  end  
  
  def female?
    return !self.gender.blank? && self.gender == "female"
  end
  
  def male?
    !female?   # presently, due to community structure, male is the default in case nothing is set
  end
  
  def platinum_account?
    !premium_expiration.nil? && premium_expiration > DateTime.now
  end
  
  def settlement_point_available?
    (settlement_points_used || 0) < (settlement_points_total || 0)
  end

  
  def can_found_outpost?
    settlement_point_available?
  end
  
  def can_takeover_settlement?
    settlement_point_available?
  end  
  
  # FIXME: this does NOT save the character after all modifications itself!!! should be corrected also inside the corresponding controller
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
      
      character.resource_pool.fill_with_start_resources_transaction(start_resource_modificator)
      
      character
    end
    
    if !character.save
      raise InternalServerError.new('Could not save the base of the character.')
    end
    
    if !npc
      character.create_inbox
      character.create_outbox
      character.create_archive
      
      # sending of welcome message is now triggered by a tutorial quest
      # Messaging::Message.create_welcome_message(character)
      
      character.create_tutorial_state
      character.tutorial_state.create_start_quest_state     
      
      cmd = Messaging::JabberCommand.grant_access(character, 'global') 
      cmd.character_id = character.id
      cmd.save
      cmd = Messaging::JabberCommand.grant_access(character, 'handel') 
      cmd.character_id = character.id
      cmd.save
      cmd = Messaging::JabberCommand.grant_access(character, 'plauderhöhle') 
      cmd.character_id = character.id
      cmd.save
      cmd = Messaging::JabberCommand.grant_access(character, 'help') 
      cmd.character_id = character.id
      cmd.save
    end
    
    return character 
  end
  
  def change_name_transaction(name)
    raise ConflictError.new("this name is already used in game") unless Fundamental::Character.find_by_name_case_insensitive(name).nil?
    
    freeChange = (self.name_change_count || 0) < 2 
    
    if !freeChange && !self.resource_pool.have_at_least_resources({Fundamental::ResourcePool::RESOURCE_ID_CASH => 20})
      raise ForbiddenError.new "character does not have enough resources to pay for the name change."
    end

    # change name on identity provider
    identity_provider_access = IdentityProvider::Access.new({
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes:                     ['5dentity'],
    })
    
    response = identity_provider_access.change_character_name(self.identifier, name)
    raise ConflictError.new("this name is already used in identity provider") unless response.code == 200
    
    self.name = name
    self.increment(:name_change_count)  

    raise InternalServerError.new 'Could not save new name.' unless self.save 
    
    if (self.name_change_count || 0) > 2 # test for 2, count was already incremented!  -> two changes are free!
        self.resource_pool.remove_resources_transaction({Fundamental::ResourcePool::RESOURCE_ID_CASH => 20})
    end
  
    return self
  end
  
  def change_gender_transaction(newGender)
    
    freeChange = (self.gender_change_count || 0) < 2  # ->  two changes are free! 
    
    if !freeChange && !self.resource_pool.have_at_least_resources({Fundamental::ResourcePool::RESOURCE_ID_CASH => 20})
      raise ForbiddenError.new "character does not have enough resources to pay for the gender change."
    end
    
    self.gender = newGender == "female" ? "female" : "male"
    self.increment(:gender_change_count)  

    raise InternalServerError.new 'Could not save new gender.' unless self.save 
    
    if (self.gender_change_count || 0) > 2  #  test for 2, count was already incremented!  -> two changes are free
        self.resource_pool.remove_resources_transaction({Fundamental::ResourcePool::RESOURCE_ID_CASH => 20})
    end
  
    return self
  end  
  
  def change_password_transaction(password)

    identity_provider_access = IdentityProvider::Access.new({
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes:                     ['5dentity'],
    })
    
    response = identity_provider_access.change_character_passwort(self.identifier, password)
    raise ConflictError.new('Could not change password.') unless response.code == 200
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
  
  def recalc_gross
    Shop::MoneyTransaction.where(partner_user_id: self.identifier).sum(:gross)
  end
  
  def update_gross
    self.gross = self.recalc_gross
  end
  
  def paying_user?
    self.shop_transactions.where(['state = ?', Shop::Transaction::STATE_CLOSED]).count > 0
  end
  
  # more than 20 days in the game (character creation to last login), >200 points, 40 logins
  def long_term?
    active? && self.score > 200 && self.login_count > 40 && self.last_login_at-20.days > self.created_at 
  end
  
  # more than 48h hours in the game (character creation to last login), >50 points, 10 logins
  def active?
    !self.score.nil? && !self.login_count.nil? && self.score > 50 && self.login_count > 10 && self.last_login_at-2.days > self.created_at 
  end

  # logged-in on two consecutive days (fist login is identical to character creation) 
  def logged_in_two_days?
    login_count >= 2 && self.last_login_at-1.days > self.created_at 
  end
  
  # logged-in at least once
  def logged_in_once?
    login_count >= 1
  end  
  
  def update_credits_spent
    self.credits_spent_total = self.shop_transactions.closed.sum(:credit_amount_booked)
  end
  
  def update_conversion_state
    return   if self.max_conversion_state == "paying"   # nothing to do, this is the highest state
    if paying_user?
      self.max_conversion_state = "paying"
      return 
    end 
    return   if self.max_conversion_state == "long_term_active"
    if long_term?
      self.max_conversion_state = "long_term_active"
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
    if !reached_game.nil?
      self.max_conversion_state = "logged_in_once"
      return
    end
    self.max_conversion_state = "registered"
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
  
  ############################################################################
  #
  #  C O N S I S T E N C Y   C H E C K S
  #
  ############################################################################  

  def check_consistency_sometimes
    return         if self.login_count.nil? || self.login_count < 3   # do NOT check consistency on character creation
    return         unless rand(100) / 100.0 < GAME_SERVER_CONFIG['character_recalc_probability']       # do the check only seldomly (determined by random event)  
    check_consistency
  end  

  def check_consistency
    logger.info(">>> COMPLETE RECALC of CHARACTER #{self.id}.")

    settlement_points = recalc_settlement_points_total
    check_and_apply_settlement_points_total(settlement_points)

    settlement_points_used = recalc_settlement_points_used
    check_and_apply_settlement_points_used(settlement_points_used)

    
    if self.changed?
      logger.warn(">>> SAVING CHARACTER AFTER DETECTING ERRORS.")
      self.save
    else
      logger.info(">>> CHARACTER OK.")
    end

    true      
  end  
  
  ############################################################################
  #
  #  C H A R A C T E R   R A N K S  and  S E T T L E M E N T   P O I N T S 
  #
  ############################################################################  


  def extend_premium_atomically(duration)
    if self.premium_expiration.nil? || self.premium_expiration < Time.now
      self.premium_expiration = Time.now.advance(:hours => duration)
    else
      self.premium_expiration = self.premium_expiration.advance(:hours => duration)
    end
    self.save
  end

  
  ############################################################################
  #
  #  C H A R A C T E R   R A N K S  and  S E T T L E M E N T   P O I N T S 
  #
  ############################################################################  
  
  def recalc_settlement_points_used
    self.settlements.count
  end
  
  def update_settlement_points_used
    self.settlement_points_used = recalc_settlement_points_used
  end  
  
  def check_and_apply_settlement_points_used(points)
    if (self.settlement_points_used || 0) !=  points
      logger.warn(">>> CONSISTENCY ERROR: SETTLEMENT POINT RECALC FOR USED POINTS DIFFERS for character #{self.id}. Old: #{self.settlement_points_used} Corrected: #{points}.")
      self.settlement_points_used = points
    end    
  end  
  
  def recalc_settlement_points_total
    sp = 0
    ranks = GameRules::Rules.the_rules.character_ranks[:mundane]
    (0..(self.mundane_rank || 0)).each do |i|
      sp += ranks[i][:settlement_points] || 0
    end
    return sp
  end

  def check_and_apply_settlement_points_total(points)
    if (self.settlement_points_total || 0) !=  points
      logger.warn(">>> CONSISTENCY ERROR: SETTLEMENT POINT RECALC FOR TOTAL POINTS DIFFERS for character #{self.id}. Old: #{self.settlement_points_total} Corrected: #{points}.")
      self.settlement_points_total = points
    end    
  end  
  
  # returns true in case the character fulfills all the prerequisites of
  # the next higher rank
  def fulfills_mundane_rank?(rank)  
    ranks = GameRules::Rules.the_rules.character_ranks[:mundane]
    return false    if ranks.nil? || ranks.empty? || rank >= ranks.count
    new_rank = ranks[rank]
    
    (self.exp || 0) >= new_rank[:exp] && (self.sacred_rank || 0) >= new_rank[:minimum_sacred_rank]
  end
    
  # advance the rank of the character to the highest 
  # rank fulfilled by the character 
  def update_mundane_rank
    while self.advance_to_next_mundane_rank_if_possible do
    end
    true
  end  
  
  def advance_to_next_mundane_rank_if_possible
    return false    unless self.fulfills_mundane_rank?((self.mundane_rank || 0) + 1)
    self.advance_to_next_mundane_rank
    return true
  end
  
  protected
  
    def advance_to_next_mundane_rank
      character_ranks              = GameRules::Rules.the_rules.character_ranks
      new_rank                     = (self.mundane_rank || 0) + 1
      skill_points_per_rank        = character_ranks[:skill_points_per_mundane_rank] || 0
      new_settlement_points        = character_ranks[:mundane][new_rank][:settlement_points] || 0    
      self.mundane_rank            = new_rank
      self.skill_points            = (self.skill_points || 0)            + skill_points_per_rank
      self.settlement_points_total = (self.settlement_points_total || 0) + new_settlement_points
    end
  
  
end


