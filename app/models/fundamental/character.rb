# encoding: utf-8

require 'identity_provider/access'
require 'game_state/avatars'

class Fundamental::Character < ActiveRecord::Base


  validates :identifier,  :uniqueness   => { :case_sensitive => true, :allow_blank => false }

  belongs_to :alliance,        :class_name => "Fundamental::Alliance",      :foreign_key => "alliance_id",  :inverse_of => :members
  
  has_one  :resource_pool,     :class_name => "Fundamental::ResourcePool",  :foreign_key => "character_id", :inverse_of => :owner
  has_one  :ranking,           :class_name => "Ranking::CharacterRanking",  :foreign_key => "character_id", :inverse_of => :character
  has_one  :home_location,     :class_name => "Map::Location",              :foreign_key => "owner_id",     :conditions => "settlement_type_id=2"   # in development there might be more than one!!!
  has_one  :tutorial_state,    :class_name => "Tutorial::State",            :foreign_key => "character_id", :inverse_of => :owner
  has_many :history_events,    :class_name => "Fundamental::HistoryEvent",  :foreign_key => "character_id", :inverse_of => :character
  
  has_one  :inbox,             :class_name => "Messaging::Inbox",           :foreign_key => "owner_id",     :inverse_of => :owner
  has_one  :outbox,            :class_name => "Messaging::Outbox",          :foreign_key => "owner_id",     :inverse_of => :owner
  has_one  :archive,           :class_name => "Messaging::Archive",         :foreign_key => "owner_id",     :inverse_of => :owner
  
  has_many :claimed_locations, :class_name => "Map::Location",              :foreign_key => "claimed_by",   :inverse_of => :claiming_character

  has_many :quests,            :class_name => "Tutorial::Quest",            :foreign_key => "state_id",     :inverse_of => :owner
  has_many :standard_assignments,  :class_name => "Assignment::StandardAssignment",  :foreign_key => "character_id",  :inverse_of => :character
  has_one  :special_assignment,    :class_name => "Assignment::SpecialAssignment",   :foreign_key => "character_id",  :inverse_of => :character
  has_many :armies,            :class_name => "Military::Army",             :foreign_key => "owner_id",     :inverse_of => :owner
  has_many :poachers,          :class_name => "Military::Army",             :foreign_key => "specific_character_id", :inverse_of => :specific_character
  has_many :locations,         :class_name => "Map::Location",              :foreign_key => "owner_id"
  has_many :regions,           :class_name => "Map::Region",                :foreign_key => "owner_id"
  has_many :alliance_shouts,   :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id"
  has_many :shop_transactions, :class_name => "Shop::Transaction",          :foreign_key => "character_id", :inverse_of => :character
  has_many :treasures,         :class_name => "Treasure::Treasure",         :foreign_key => "character_id", :inverse_of => :finder
  has_many :special_offers_transactions, :class_name => "Shop::SpecialOffersTransaction", :foreign_key => "character_id", :inverse_of => :character
  has_many :purchases,         :class_name => "Shop::Purchase",             :foreign_key => "character_id", :inverse_of => :character
  has_many :settlements,       :class_name => "Settlement::Settlement",     :foreign_key => "owner_id",     :inverse_of => :owner
  has_many :fortresses,        :class_name => "Settlement::Settlement",     :foreign_key => "owner_id",     :conditions => ["type_id = ?", Settlement::Settlement::TYPE_FORTRESS]
  has_many :bases,             :class_name => "Settlement::Settlement",     :foreign_key => "owner_id",     :conditions => ["type_id = ?", Settlement::Settlement::TYPE_HOME_BASE]
  has_many :outposts,          :class_name => "Settlement::Settlement",     :foreign_key => "owner_id",     :conditions => ["type_id = ?", Settlement::Settlement::TYPE_OUTPOST]

  has_many :construction_effects, :class_name => "Effect::ConstructionEffect", :foreign_key => "character_id", :inverse_of => :character
  has_many :experience_effects,   :class_name => "Effect::ExperienceEffect", :foreign_key => "character_id", :inverse_of => :character

  has_one  :artifact,          :class_name => "Fundamental::Artifact",      :foreign_key => "owner_id",     :inverse_of => :owner
  has_one  :setting,           :class_name => "Fundamental::Setting",       :foreign_key => "character_id", :inverse_of => :owner
  
  has_many :retention_mails,   :class_name => "Fundamental::RetentionMail", :foreign_key => "character_id", :inverse_of => :character
  belongs_to :last_retention_mail, :class_name => "Fundamental::RetentionMail", :foreign_key => "last_retention_mail_id"

  has_many :sign_ins,          :class_name => "Backend::SignInLogEntry",    :foreign_key => "character_id", :inverse_of => :character
  has_one  :sign_up,           :class_name => "Backend::SignInLogEntry",    :foreign_key => "character_id", :conditions => ["sign_up = ?", true]

  has_many :leads_battle_factions, :class_name => "Military::BattleFaction",  :foreign_key => "leader_id", :inverse_of => :leader
  has_many :battle_results,    :class_name => "Military::BattleCharacterResult",  :foreign_key => "character_id", :inverse_of => :character

  has_many :send_likes,        :class_name => "LikeSystem::Like",           :foreign_key => "sender_id", :inverse_of => :sender
  has_many :received_likes,    :class_name => "LikeSystem::Like",           :foreign_key => "receiver_id", :inverse_of => :receiver

  has_many :send_dislikes,     :class_name => "LikeSystem::Dislike",        :foreign_key => "sender_id", :inverse_of => :sender
  has_many :received_dislikes, :class_name => "LikeSystem::Dislike",        :foreign_key => "receiver_id", :inverse_of => :receiver
  
  has_one  :alliance_leader_candidate, :class_name => "Fundamental::AllianceLeaderVote", :foreign_key => "candidate_id", :inverse_of => :candidate
  has_one  :alliance_leader_vote, :class_name => "Fundamental::AllianceLeaderVote", :foreign_key => "voter_id", :inverse_of => :voter

  has_one  :spawn_poacher_event,  :class_name => "Event::Event",            :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'spawn_poacher'"
  has_many :poacher_treasures,    :class_name => "Fundamental::Treasure",   :foreign_key => "specific_character_id", :inverse_of => :specific_character

  attr_readable :id, :identifier, :name, :lvel, :exp, :att, :def, :wins, :losses, :health_max, :health_present, :health_updated_at, :alliance_id, :alliance_tag, :alliance_color, :base_location_id, :base_region_id, :created_at, :updated_at, :base_node_id, :score, :npc, :fortress_count, :mundane_rank, :sacred_rank, :gender, :banned, :received_likes_count, :received_dislikes_count, :victories, :defeats, :avatar_string, :description, :tutorial_finished_at, :can_redeem_retention_bonus_at, :can_redeem_retention_bonus_start_time, :has_limited_grid,   :as => :default
  attr_readable *readable_attributes(:default), :lang,                                                                         :as => :ally 
  attr_readable *readable_attributes(:ally), :cannot_join_alliance_until, :premium_account, :locked, :locked_by, :locked_at, :character_unlock_, :skill_points, :premium_expiration, :start_variant, :premium_expiration_displayed_at, :character_queue_, :name_change_count, :last_login_at, :settlement_points_total, :settlement_points_used, :notified_mundane_rank, :notified_sacred_rank, :gender_change_count, :ban_reason, :ban_ended_at, :staff_roles, :exp_production_rate, :exp_bonus_total, :kills, :same_ip, :playtime, :assignment_level, :special_offer_dialog_count, :special_offer_displayed_at, :divine_supporter, :image_set_id, :platinum_lifetime, :moved_at, :gc_player_id, :gc_rejected_at, :gc_player_id_connected_at, :fb_player_id, :fb_rejected_at, :fb_player_id_connected_at, :max_poachers_count, :spawned_poachers_count, :last_poacher_cycle_update, :trade_resources_count, :as => :owner
  attr_readable *readable_attributes(:owner), :last_request_at, :max_conversion_state, :reached_game, :credits_spent_total, :insider_since,   :as => :staff
  attr_readable *readable_attributes(:owner), :last_request_at, :max_conversion_state, :reached_game,                          :as => :developer
  attr_readable *readable_attributes(:staff),                                                                                  :as => :admin

  before_save :sync_alliance_tag
  before_save :sync_alliance_color
  before_save :update_mundane_rank
  
  before_save :update_experience_on_production_rate_changes
  before_save :update_experience_on_bonus_changes
  before_save :update_construction_bonus_total
  before_save :update_experience_bonus_total
  before_save :join_alliance_check

  after_save  :propagate_insider_since_changes_to_chat

  after_save  :propagate_alliance_membership_changes_to_resource_pool
  after_save  :propagate_alliance_membership_changes_to_artifact
  after_save  :propagate_alliance_membership_changes
  after_save  :propagate_alliance_membership_changes_to_alliance_leader_vote
  after_save  :propagate_name_changes
  after_save  :propagate_avatar_changes
  after_save  :propagate_score_changes
  after_save  :propagate_kills_changes
  after_save  :propagate_like_changes
  after_save  :propagate_victory_changes
  after_save  :propagate_defeat_changes
  after_save  :propagate_dislike_changes
  after_save  :propagate_gender_changes
  after_save  :propagate_fortress_count_changes
  after_save  :propagate_alliance_bonus_to_alliance
  after_save  :propagate_construction_bonus
  after_save  :propagate_divine_supporter_changes
  after_save  :propagate_image_set_changes
  after_save  :manage_assignments_on_level_change
  after_save  :check_for_new_quests_triggered_by_logged_in_on_second_day
  after_save  :check_for_new_quests_triggered_by_mundane_rank
  
  before_create :init_retention_bonus

  after_commit :check_consistency_sometimes
  
  after_find  :update_experience_if_necessary
  
  scope :npc,        where(['(npc = ?)', true])
  scope :non_npc,    where(['(npc IS NULL OR npc = ?)', false])
  scope :non_banned, where(['(banned IS NULL OR banned = ?)', false])
  scope :platinum,   where(['premium_expiration IS NOT NULL AND premium_expiration > ?', Rails.env.development? || Rails.env.test? ? 'datetime("now")' : 'NOW()'])
  scope :case_insensitive_identifier, lambda { |uid| where(["lower(identifier) = ?", uid.downcase]) }
  
  scope :paying,           where(max_conversion_state: "paying")
  scope :long_term_active, where(max_conversion_state: "long_term_active")
  scope :active,           where(max_conversion_state: "active")
  scope :second_day,       where(max_conversion_state: "logged_in_two_days")
  scope :ten_minutes,      where(max_conversion_state: "ten_minutes")
  scope :logged_in_once,   where(max_conversion_state: "logged_in_once")
  
  scope :churned,          lambda { where(['last_login_at IS NULL OR last_login_at < ?', Time.now - 1.weeks]) }

  scope :not_deleted,      where(deleted_from_game: false)
  scope :deleted,          where(deleted_from_game: true)

  scope :not_started,      where('deleted_from_game = ? AND base_location_id IS NULL AND last_request_at < ?', false, Time.now - 1.hours)

  # used by player deletion script
  scope :shortly_before_deletable, lambda{ |now| not_deleted.where([
    'last_login_at < ?', 
    now - (GAME_SERVER_CONFIG['player_deletion_interval'] - 1).days + 12.hours,
  ]).order('last_login_at ASC') }

  scope :shortly_before_deletable_inactive, lambda{ |now| not_deleted.where([
    'last_login_at < ? AND (login_count < 2 OR tutorial_finished_at IS NULL)',
    now - (GAME_SERVER_CONFIG['inactive_player_deletion_interval'] - 1).days + 12.hours
  ]).order('last_login_at ASC') }


  scope :deletable, lambda { |now| not_deleted.where([                                        # older than 30 days or no login and older than 1 day
    '(last_login_at IS NULL AND updated_at < ?) OR last_login_at < ?',
    now - 1.days,
    now - GAME_SERVER_CONFIG['player_deletion_interval'].days + 12.hours
  ]).order('last_login_at ASC') }

  scope :deletable_inactive, lambda { |now| not_deleted.where([
    '(last_login_at IS NULL AND updated_at < ?) OR (last_login_at < ? AND (login_count < 2 OR tutorial_finished_at IS NULL))',
    now - 1.days,
    now - GAME_SERVER_CONFIG['inactive_player_deletion_interval'].days + 12.hours
  ]).order('last_login_at ASC') }
  
  #used by retention mail
  scope :retention_no_mail_pending,  not_deleted.where('last_retention_mail_sent_at IS NULL OR last_login_at > last_retention_mail_sent_at')
  scope :retention_played_too_short, not_deleted.where([
    Rails.env.development? || Rails.env.test? ?
      "datetime('now', '-? hours') < created_at AND created_at < datetime('now', '-? hours') AND last_login_at < datetime('now', '-? hours')" :
      "NOW() - INTERVAL '? hour'   < created_at AND created_at < NOW() - INTERVAL '? hour'   AND last_login_at < NOW() - INTERVAL '? hour'",
    44, 24, 20  # 44h ago > created > 24h ago and last login > 20h ago 
  ])
  # Fundamental::Character.where(["NOW() - INTERVAL '? hour'   < created_at AND created_at < NOW() - INTERVAL '? hour'   AND last_login_at < NOW() - INTERVAL '? hour'", 44, 24, 20])  
  scope :retention_paused_too_long,  not_deleted.where([
    Rails.env.development? || Rails.env.test? ?
      "created_at < datetime('now', '-? hours') AND datetime('now', '-? hours') < last_login_at AND last_login_at < datetime('now', '-? hours')" :
      "created_at < NOW() - INTERVAL '? hour'   AND NOW() - INTERVAL '? hour'   < last_login_at AND last_login_at < NOW() - INTERVAL '? hour' ",
    44, 49, 48  # created > 44h ago and  49h ago > last login > 48h (2 days) ago 
  ])
  # Fundamental::Character.where(["created_at < NOW() - INTERVAL '? hour'  AND NOW() - INTERVAL '? hour'  < last_login_at AND last_login_at < NOW() - INTERVAL '? hour' ", 44, 49, 48])
  
  scope :retention_getting_inactive, not_deleted.where([
    Rails.env.development? || Rails.env.test? ?
      "datetime('now', '-? hours') < last_login_at AND last_login_at < datetime('now', '-? hours')" :
      "NOW() - INTERVAL '? hour'   < last_login_at AND last_login_at < NOW() - INTERVAL '? hour' ",
    145, 144   # 145h ago > last login > 144h (6 days) ago 
  ])

  @identifier_regex = /[a-z]{16}/i
  
  def self.search(search)
    if search
      where('identifier LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def lastactiv
    if( (Time.now - last_login_at) < 24.hours)   
              "green" # ActionController::Base.helpers.image_tag("Green.png") 
            elsif  ((Time.now - last_login_at) > 24.hours && (Time.now - last_login_at) < 96.hours )
              "yellow" # ActionController::Base.helpers.image_tag("Yellow.png")
             else 
              "red" #ActionController::Base.helpers.image_tag("Red.png")
             end
  end

  def self.find_by_id_or_identifier(user_identifier)
    identity = Fundamental::Character.find_by_id(user_identifier) if Fundamental::Character.valid_id?(user_identifier)
    identity = Fundamental::Character.find_by_identifier(user_identifier) if identity.nil? && Fundamental::Character.valid_identifier?(user_identifier)
    identity
  end
  
  def self.find_by_name_case_insensitive(name)  
    Fundamental::Character.first(:conditions => [ "lower(name) = ?", name.downcase ])
  end

  def self.valid_identifier?(identifier)
    identifier.index(@identifier_regex) != nil
  end
  
  def self.valid_id?(id)
    id.index(/^[1-9]\d*$/) != nil
  end

  def self.update_all_conversions
    Fundamental::Character.all.each do |character|
      character.update_conversion_state
      if !character.logged_in_on_second_day? && character.created_at > DateTime.now - 3.days && !character.last_request_at.nil?
        start = character.created_at.beginning_of_day
        if character.last_request_at > start + 1.days && character.last_request_at < start + 2.days
          character.logged_in_on_second_day = true
        end
      end
      character.save
    end
  end
  
  def self.update_all_credits_spent
    Fundamental::Character.all.each do |character|
      character.update_credits_spent
      character.update_gross
      character.save
    end
  end  
  
  def referer
    sign_up.nil? ? nil : sign_up.referer
  end
  
  # updates the playtime of this character. called by the current_character
  # methods during authorization of a request.
  def update_last_request_at
    if self.last_request_at.nil? || self.last_request_at + 1.minutes < Time.now
      difference = Time.now - (self.last_request_at ||Time.now)
      self.update_column(:playtime, (playtime || 0.0) + (difference <= 120.0 ? difference : 30.0))     # assumption: larger than 2 minutes -> user was offline inbetween , so just count the startet minute
      self.tutorial_state.check_for_new_quests('play_time_trigger') unless self.tutorial_state.nil?
      self.update_column(:last_request_at, Time.now)  # change timestamp without triggering before / after handlers, without update updated_at
    end
  end

  def redeem_xp_start_bonus(xp_bonus)
    bonus = ActiveSupport::JSON.decode(xp_bonus)
   # if bonus['client_identifier'] == GAME_SERVER_CONFIG['scope']
      logger.info "REDEEM XP GIFT FOR CHARACTER #{self.identifier}: #{bonus['bonus'].to_f}"
      self.experience_effects.create({
        type_id:      Effect::ExperienceEffect::EXPERIENCE_EFFECT_TYPE_START_GIFT,
        bonus:        bonus['bonus'].to_f,
        origin_id:    self.id,
      })
  #  end
  end

  def redeem_start_resources(start_resources)
    list = ActiveSupport::JSON.decode(start_resources)
    #if list['client_identifier'] == GAME_SERVER_CONFIG['scope']
      (list['resources'] || []).each do |resource|
        self.resource_pool.add_resource_atomically(resource['resource_type_id'].to_i, resource['amount'].to_f)
      end
    #end
  end
  
  def identity_provider_access
    @identity_provider_access ||= IdentityProvider::Access.new({
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes:                     ['5dentity'],
    })
  end

  def redeem_startup_gift(gift_list)
    list = ActiveSupport::JSON.decode(gift_list)
    logger.info "REDEEM RESOURCE GIFT FOR CHARACTER #{self.identifier}: #{ list.inspect }"
    (list || []).each do |resource_gift|    # nothing else allowed at present
      self.resource_pool.add_resource_atomically(resource_gift['resource_type_id'].to_i, resource_gift['amount'].to_f)
    end

    response = identity_provider_access.deliver_gift_received_notification(self, list || [])
  end

  def redeem_tutorial_end_rewards
    self.extend_premium_atomically(Tutorial::Tutorial.the_tutorial.tutorial_reward[:platinum_duration])
  end

  def locale
    if self.lang.to_sym == :de
      :de_DE
    else
      :en_US
    end
  end  
  
  def can_create_alliance?
    !character_unlock_alliance_creation_count.blank? && character_unlock_alliance_creation_count >= 1
  end
  
  def alliance_leader?
    !self.alliance.nil? && self.alliance.leader_id == self.id
  end

  def moved_home_settlement?
    !self.moved_at.nil?
  end

  def max_finished_quest
    tutorial_state.nil? ? nil : tutorial_state.finished_quests.maximum(:quest_id)
  end
  
  def num_finished_quests
    tutorial_state.nil? ? 0 : tutorial_state.finished_quests.count
  end
  
  def num_open_quests
    tutorial_state.nil? ? 0 : tutorial_state.open_quests.count
  end
  
  
  def online?
    !self.last_request_at.nil? && self.last_request_at + 2.minutes > Time.now
  end
  
  def offline?
    !self.online?
  end  
  
  def female?
    !self.gender.blank? && self.gender == "female"
  end
  
  def male?
    !female?   # presently, due to community structure, male is the default in case nothing is set
  end

  def platinum_account?
    !premium_expiration.nil? && premium_expiration > DateTime.now
  end

  def set_platinum_lifetime
    self.premium_expiration = Time.now.advance(:years => 10)
    self.platinum_lifetime = true
  end

  def bought_platinum?
    !self.shop_transactions.where("state > 4 and offer like '%Platinum%'").empty?
  end
  
  def settlement_point_available?
    (settlement_points_used || 0) < (settlement_points_total || 0)
  end

  def show_special_offers?
    !tutorial_finished_at.nil? && tutorial_finished_at.advance(:days => GAME_SERVER_CONFIG['special_offer_interval']) > DateTime.now
  end

  def can_found_outpost?
    settlement_point_available?
  end
  
  def can_found_home_base?
    self.settlements.count == 0  # can always found at least one settlement, even without settlement point
  end
  
  def can_takeover_settlement?
    settlement_point_available?
  end  

  def settled_regions
    regions = {}
    self.settlements.each do |settlement|
      regions[settlement.region_id] = settlement.region
    end

    return regions.values
  end
  
  def voted_for_candidate_id
    return nil     if self.alliance_leader_vote.nil?
      
    self.alliance_leader_vote.candidate_id
  end
  
  def self.fetch_identity_for_identifier(identifier)
    identity_provider_access = IdentityProvider::Access.new({
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes:                     ['5dentity'],
    })
    
    response = identity_provider_access.fetch_identity(identifier)
    logger.info "IDENTITY RESPONSE #{ response.blank? ? 'BLANK' : response.inspect }."
    identity = {}
    if response.code == 200
      identity = response.parsed_response
    end
    
    identity
  end
  
  def fetch_identity
    Fundamental::Character.fetch_identity_for_identifier(self.identifier)
  end
  
  
  def self.fetch_identity_properties_for_identifier(identifier)
    identity_provider_access = IdentityProvider::Access.new({
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes:                     ['5dentity'],
    })
    
    # fetch persistent character properties from identity provider  
    response = identity_provider_access.fetch_identity_properties(identifier)
    logger.info "START RESPONSE #{ response.blank? ? 'BLANK' : response.inspect }."
    
    parsed_properties = {
      start_resource_modificator: 1.0,
      start_resource_bonuses: [],
      start_resources: [],
      start_xp_bonuses: [],
    }
    
    if response.code == 200
      properties = response.parsed_response
      logger.info "START PROPERTIES #{ properties.blank? ? 'BLANK' : properties.inspect }."

      unless properties.empty?
        properties.each do |character_property|
          if !character_property.nil? && !character_property['data'].blank?
            unless character_property['data']['start_resource_modificator'].blank?
              property_value = character_property['data']['start_resource_modificator'].to_f
              logger.debug "START PROPERTY_VALUE #{ property_value }."
              parsed_properties[:start_resource_modificator] = property_value if property_value > 0
              logger.info "START RESOURCE MODIFICATOR #{ parsed_properties[:start_resource_modificator] }."
            end
            unless character_property['data']['start_resource_bonus'].blank?
              parsed_properties[:start_resource_bonuses] << character_property['data']['start_resource_bonus'].to_json # start_resource_bonus is saved as serialized hash, not as string
              logger.info "START RESOURCE BONUS #{ parsed_properties[:start_resource_bonuses].inspect }."
            end
            unless character_property['data']['start_resources'].blank?
              parsed_properties[:start_resources] << character_property['data']['start_resources'].to_json # start_resource_bonus is saved as serialized hash, not as string
              logger.info "START RESOURCES #{ parsed_properties[:start_resources].inspect }."
            end
            unless character_property['data']['start_xp_bonus'].blank?
              parsed_properties[:start_xp_bonuses] << character_property['data']['start_xp_bonus'].to_json # start_resource_bonus is saved as serialized hash, not as string
              logger.info "START XP BONUS #{ parsed_properties[:start_xp_bonuses].inspect }."
            end
          end
        end
      end
    end
    
    parsed_properties
  end
  
  def fetch_identity_properties
    Fundamental::Character.fetch_identity_properties_for_identifier(self.identifier)
  end
  
  
  def self.fetch_signup_gift_for_identifier_and_client(identifier, client_id)
    identity_provider_access = IdentityProvider::Access.new({
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes:                     ['5dentity'],
    })
  
    response = identity_provider_access.fetch_signup_gift(identifier, client_id)
    logger.info "START RESPONSE #{ response.blank? ? 'BLANK' : response.inspect }."

    if response.code == 200
      gifts = response.parsed_response
      logger.info "START PROPERTIES #{ properties.blank? ? 'BLANK' : properties.inspect }."

      unless gifts.nil? || gifts.empty?
        signup_gift = gifts[0]
        
        if !signup_gift.nil? && !signup_gift['data'].blank?
          return signup_gift['data']
        end
      end
    end
    
    nil
  end
  
  def fetch_signup_gift_for_client(client_id)
    Fundamental::Character.fetch_signup_gift_for_identifier_and_client(self.identifier, client_id)
  end
  
  
  # FIXME: this does NOT save the character after all modifications itself!!! should be corrected also inside the corresponding controller
  def self.create_new_character(identifier, name, args = {})
    resource_modificator = args[:resource_modificator] || 1.0
    npc                  = args[:npc]                  || false
    start_location       = args[:location]             || nil
    gender               = args[:gender]               || nil
    lang                 = args[:lang]                 || :en
    
    character = Fundamental::Character.new({
      identifier: identifier,
      name: name,
      npc:  npc,
      exp:  0,
      start_variant: 1,
      gender: gender,
      lang: lang,
      has_limited_grid: true,
    })
    
    avatar = GameState::Avatars.new
    character.avatar_string = avatar.create_random_avatar_string(gender.nil? || gender == 'male')

    unless character.save
      raise InternalServerError.new('Could not create new character.')
    end

    character.create_resource_pool
    
    raise InternalServerError.new('Could not save the base of the character.')  if !character.save

    unless npc
      character.create_ranking({
        character_name: name,
      })

      location = start_location.nil? ? Map::Location.find_empty_with_neighbors : start_location
      if !location || !character.claim_location(location)
        character.destroy
        raise InternalServerError.new('Could not claim an empty location.')
      end

      Settlement::Settlement.create_settlement_at_location(location, 2, character)  # 2: home base

      character.base_location_id = location.id              # TODO is this the home_location_id?
      character.base_region_id = location.region_id
      character.base_node_id = location.region.node_id

      character.resource_pool.fill_with_start_resources_transaction(resource_modificator)

      character
    end
    
    unless character.save
      raise InternalServerError.new('Could not save the base of the character.')
    end

    unless npc
      character.create_inbox
      character.create_outbox
      character.create_archive            

      # sending of welcome message is now triggered by a tutorial quest
      # Messaging::Message.create_welcome_message(character)

      character.create_tutorial_state
      character.tutorial_state.create_start_quest_state

      ActiveRecord::Base.transaction do  
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
        cmd = Messaging::JabberCommand.grant_access(character, 'whisperingcavern')
        cmd.character_id = character.id
        cmd.save
        cmd = Messaging::JabberCommand.grant_access(character, 'beginner')
        cmd.character_id = character.id
        cmd.save
      end

      # HACK for tutorial battle quest (place poacher at home_location)
      Military::Army.create_npc(character.home_location, 1, character) unless character.home_location.nil?
    end
    
    character 
  end
  
  # creates a character and a settler unit, not a settlement
  def self.create_new_character_and_settler(identifier, name, args = {})
    npc                  = args[:npc]                  || false
    start_location       = args[:location]             || nil
    gender               = args[:gender]               || nil
    lang                 = args[:lang]                 || :en
    
    character = Fundamental::Character.new({
      identifier: identifier,
      name: name,
      npc:  npc,
      exp:  0,
      start_variant: 2,
      gender: gender,
      lang: lang,
    })
    
    avatar = GameState::Avatars.new
    character.avatar_string = avatar.create_random_avatar_string(gender.nil? || gender == 'male')

    unless character.save
      raise InternalServerError.new('Could not create new character.')
    end

    logger.debug "Character lang: #{character.lang} and locale: #{character.locale}."
    
    character.create_resource_pool
    
    raise InternalServerError.new('Could not save the base of the character.')  if !character.save

    unless npc
      location = start_location.nil? ? Map::Location.find_empty_with_neighbors : start_location
      if !location || !character.claim_location(location)
        character.destroy
        raise InternalServerError.new('Could not claim an empty location.')
      end

      Military::Army.create_settler_at_location(location, character)
      
      character
    end
    
    unless character.save
      raise InternalServerError.new('Could not save the base of the character.')
    end

    unless npc
      character.create_inbox
      character.create_outbox
      character.create_archive            

      # sending of welcome message is now triggered by a tutorial quest
      # Messaging::Message.create_welcome_message(character)

      character.create_tutorial_state
      character.tutorial_state.create_settler_start_quest_state

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
      cmd = Messaging::JabberCommand.grant_access(character, 'whisperingcavern')
      cmd.character_id = character.id
      cmd.save
      cmd = Messaging::JabberCommand.grant_access(character, 'beginner')
      cmd.character_id = character.id
      cmd.save
    end
    
    character 
  end
  
  
  def completed_tutorial?
    tutorial_state = self.tutorial_state
    return false    if tutorial_state.nil?
    displayed_at   = self.tutorial_state.displayed_tutorial_completion_notice_at
    !displayed_at.nil?
  end
  
  def completed_tutorial_on_first_day?
    tutorial_state = self.tutorial_state
    return false     if tutorial_state.nil?
    displayed_at   = self.tutorial_state.displayed_tutorial_completion_notice_at
    return false     if displayed_at.nil?
    return displayed_at < self.created_at + 1.days
  end
    
  def init_retention_bonus
    if !self.npc? && self.can_redeem_retention_bonus_at.nil?
      self.can_redeem_retention_bonus_start_time = DateTime.now
      self.can_redeem_retention_bonus_at = (DateTime.now + 1.days).change({ hour: 20, min: 0, sec: 0 }) 
    end
  end
  
  def can_redeem_retention_bonus?
    return false if self.can_redeem_retention_bonus_at.nil? || can_redeem_retention_bonus_start_time.nil?
    return DateTime.now > self.can_redeem_retention_bonus_at
  end
  
  def redeem_retention_bonus
    # TODO: fetch from rules / XML
    rewards = { :resource_rewards => [ {:amount => 8000, :resource => 'resource_stone'},
    {:amount => 8000, :resource => 'resource_wood'}, {:amount => 8000, :resource => 'resource_fur'} ] }
    raise BadRequestError.new('no rewards found in for retention bonus') if rewards.nil?
    resource_rewards = rewards[:resource_rewards]

    # calc resources
    resources = {}
    unless resource_rewards.nil?
      resource_rewards.each do |resource_reward|
        raise BadRequestError.new('no resource_reward given') if resource_reward.nil?
        
        amount = resource_reward[:amount]
        raise BadRequestError.new('no amount given') if amount.nil?
        raise BadRequestError.new('amount is negative') if amount < 0
        
        resource_symbolic_id = resource_reward[:resource]
        raise BadRequestError.new('no resource id given') if resource_symbolic_id.nil?
        
        resource_type = nil
        GameRules::Rules.the_rules().resource_types.each do |type|
          logger.debug "grant_resources: #{type[:symbolic_id]} #{resource_symbolic_id}" 
          if type[:symbolic_id].to_s == resource_symbolic_id.to_s
            resource_type = type
            break
          end
        end
        raise BadRequestError.new("no resource type found for resource symbolic id #{resource_symbolic_id}") if resource_type.nil?
        
        resources[resource_type[:id]] = (resources[resource_type[:id]] || 0) + amount
      end
    end

    self.can_redeem_retention_bonus_start_time = nil
    self.save
                
    # reward resources
    self.resource_pool.add_resources_transaction(resources)        
  end
  
  
  def change_name_transaction(name)
    raise InternalServerError.new("this name contains invalid characters") if name.include?('|')
    raise ConflictError.new("this name is already used in game") unless Fundamental::Character.find_by_name_case_insensitive(name).nil?

    change_character_name_rules = GameRules::Rules.the_rules.change_character_name
    
    free_change = (self.name_change_count || 0) < change_character_name_rules[:free_changes]
    
    if !free_change && !self.resource_pool.have_at_least_resources({change_character_name_rules[:resource_id] => change_character_name_rules[:amount]})
      raise ForbiddenError.new "character does not have enough resources to pay for the name change."
    end

    # change name on identity provider
    response = identity_provider_access.change_character_name(self.identifier, name)
    raise ConflictError.new("this name is already used in identity provider") unless response.code == 200
    
    self.name = name
    self.increment(:name_change_count)  

    raise InternalServerError.new 'Could not save new name.' unless self.save 

    unless free_change
      self.resource_pool.remove_resources_transaction({change_character_name_rules[:resource_id] => change_character_name_rules[:amount]})
    end
  
    self
  end
  
  def change_gender_transaction(new_gender)
    change_character_gender_rules = GameRules::Rules.the_rules.change_character_gender

    free_change = (self.gender_change_count || 0) < change_character_gender_rules[:free_changes]

    if !free_change && !self.resource_pool.have_at_least_resources({change_character_gender_rules[:resource_id] => change_character_gender_rules[:amount]})
      raise ForbiddenError.new "character does not have enough resources to pay for the gender change."
    end
    
    self.gender = new_gender == "female" ? "female" : "male"
    self.increment(:gender_change_count)  

    avatar = GameState::Avatars.new
    avatar.create_random_avatar_string(new_gender.nil? || new_gender == "male")
    self.avatar_string = avatar.avatar_string
    
    raise InternalServerError.new 'Could not save new gender.' unless self.save 
    
    unless free_change
      self.resource_pool.remove_resources_transaction({change_character_gender_rules[:resource_id] => change_character_gender_rules[:amount]})
    end
  
    self
  end  
  
  def change_password_transaction(password)
    response = identity_provider_access.change_character_passwort(self.identifier, password)
    raise ConflictError.new('Could not change password.') unless response.code == 200
  end  
  
  
  
  def connect_facebook_transaction(fb_player_id, fb_access_token)
    response = identity_provider_access.connect_facebook(fb_player_id, fb_access_token, self.identifier)
    raise ConflictError.new('Facebook user is already connected') if response.code == 409    
    raise ForbiddenError.new('Character is already connected')    if response.code == 400    
    raise BadRequestError.new('Could not connect player.')        unless response.code == 200    
    
    self.fb_player_id = fb_player_id
    self.fb_player_id_connected_at = Time.now
    self.fb_rejected_at = nil
    self.save
  end
  
  
  # should claim a location in a thread-safe way.... (e.g. check, that owner hasn't changed)
  def claim_location(location)
    location.claim!(self)
  end
    
  def add_like_for(character)
    like = self.send_likes.new({receiver: character})
    if like.validate_like
      self.send_likes_count += 1
      if self.save
        character.received_likes_count += 1
        character.save
      else
        false
      end
    else
      false
    end
  end
    
  def add_dislike_for(character)
    dislike = self.send_dislikes.new({receiver: character})
    if dislike.validate_dislike
      self.send_dislikes_count += 1
      if self.save
        character.received_dislikes_count += 1
        character.save
      else
        false
      end
    else
      false
    end
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
    round_started_at = Fundamental::RoundInfo.first.started_at
    if round_started_at.nil?
      Shop::MoneyTransaction.where(partner_user_id: self.identifier).no_charge_back.completed.sum(:gross)
    else
      Shop::MoneyTransaction.where(partner_user_id: self.identifier).since_date(round_started_at).no_charge_back.completed.sum(:gross)
    end
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
  
  def ten_minutes?
    ((playtime || 0.0) / 60.0) >= 10.0
  end
  
  # logged-in at least once
  def logged_in_once?
    login_count >= 1 && (reached_game? || playtime >= 60.0 || num_finished_quests > 0)  # a minute in game or pressed button in welcome dialog or solved a quest.
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
    return   if self.max_conversion_state == "ten_minutes"
    if ten_minutes?
      self.max_conversion_state = "ten_minutes"
      return 
    end     
    # return   if self.max_conversion_state == "logged_in_once"
    if logged_in_once?
      self.max_conversion_state = "logged_in_once"
      return
    end
    self.max_conversion_state = "registered"
  end

  def new_poacher_spawn_possible?
    self.poachers.count < self.max_poachers_count && self.spawned_poachers_count < self.max_poachers_count
  end

  def update_poachers
    create_treasure = false

    # update poacher cycle variables
    if self.last_poacher_cycle_update.nil? || self.last_poacher_cycle_update <= GAME_SERVER_CONFIG['poacher_cycle_update_interval'].hours.ago
      self.last_poacher_cycle_update = Time.now
      self.max_poachers_count = self.settlement_points_total * 2 # TODO: Maybe define formula in rules?
      self.spawned_poachers_count = 0

      # if poachers already exists, add a treasure
      if self.poachers.count > 0
        poachers_without_treasures = self.poachers.without_treasure
        Fundamental::Treasure.create_for_poacher(poachers_without_treasures.offset(Random.rand(poachers_without_treasures.count)).first) if !poachers_without_treasures.empty?
      else
        create_treasure = true
      end

      self.save
    end

    # place a new poacher if needed
    if self.new_poacher_spawn_possible?
      poacher = Military::Army.place_poacher_for(self)
      if !poacher.nil?
        self.spawned_poachers_count += 1
        Fundamental::Treasure.create_for_poacher(poacher) if create_treasure
        self.save
      end
    end

    self.create_spawn_poacher_event
  end

  def create_spawn_poacher_event(time = nil)
    # ensure max_poachers_count is not nil and != 0
    self.max_poachers_count = self.settlement_points_total * 2 if self.max_poachers_count.nil? || self.max_poachers_count == 0 # TODO: Maybe define formula in rules?

    # check if next event should spawn new poacher or only update poacher cycle variables
    if self.new_poacher_spawn_possible?
      # create new event for new spawn; if time is nil use config time
      event_time = (time.nil?) ? Time.now + (GAME_SERVER_CONFIG['poacher_cycle_update_interval'].hours / self.max_poachers_count) : Time.now + time
    else
      # create new event for update cycle
      event_time = self.last_poacher_cycle_update + GAME_SERVER_CONFIG['poacher_cycle_update_interval'].hours
    end

    # build new spawn poacher event
    event = self.build_spawn_poacher_event(
      character_id: self.id,
      execute_at: event_time,
      event_type: "spawn_poacher",
      local_event_id: self.id
    )
    event.save
  end

  def update_spawn_poacher_event
    return if self.last_poacher_cycle_update.nil?
    next_update_cycle_execution = self.last_poacher_cycle_update + GAME_SERVER_CONFIG['poacher_cycle_update_interval'].hours

    # find existing spawn poacher event which would update cycle variables
    existing_events = Event::Event.where(character_id: self.id, event_type: 'spawn_poacher', execute_at: next_update_cycle_execution)
    event = existing_events.first unless existing_events.nil?

    if !event.nil? # if next event should update cycle variables
      event_time = Time.now + (GAME_SERVER_CONFIG['poacher_cycle_update_interval'].hours / self.max_poachers_count)
      event.execute_at = event_time if self.new_poacher_spawn_possible? && event_time < next_update_cycle_execution # update spawn event if spawn is possible within current cycle
      event.save
    end
  end

  # ##########################################################################
  #
  #   Alliance related stuff
  #
  # ##########################################################################
  
  def leave_alliance(alliance)
    alliance.remove_character(self)
  end
  
  def join_alliance(alliance)
    alliance.add_character(self)
  end

  def sync_alliance_tag
    alliance_change = self.changes[:alliance_id]
    if !alliance_change.blank? && !self.alliance.nil?
      self.alliance_tag = self.alliance.tag
    end
  end

  def sync_alliance_color
    alliance_change = self.changes[:alliance_id]
    if !alliance_change.blank? && !self.alliance.nil?
      self.alliance_color = self.alliance.color
    end
  end

  # Function for propagating change of alliance membership to redundant fields.
  # This uses update_all direct queries because the Rails way of looping
  # through models (selecting, instantiating, saving) would potentially take
  # too long (there might be several hundreds of settlements, locations and
  # armies involved).
  def propagate_alliance_membership_changes
    alliance_change       = self.changes[:alliance_id]
    alliance_tag_change   = self.changes[:alliance_tag]
    alliance_color_change = self.changes[:alliance_color]

    redundancies = [
      { :model => Map::Location,             :field => :owner_id },
      { :model => Map::Region,               :field => :owner_id },
      { :model => Military::Army,            :field => :owner_id },
      { :model => Settlement::Settlement,    :field => :owner_id },
      { :model => Ranking::CharacterRanking, :field => :character_id, :handlers_needed => true },
    ]
    
    if !alliance_change.blank? || !alliance_tag_change.blank? || !alliance_color_change.blank?
      set_clause = { }
      set_clause[:alliance_id]    = alliance_change[1]        unless alliance_change.nil?
      set_clause[:alliance_tag]   = alliance_tag_change[1]    unless alliance_tag_change.nil?
      set_clause[:alliance_color] = alliance_color_change[1]  unless alliance_color_change.nil?
      set_clause[:updated_at]     = DateTime.now


      redundancies.each do |entry| 
        if !entry[:handlers_needed].nil? && entry[:handlers_needed] == true
          entry[:model].where(entry[:field] => self.id).each do |item|
            item.alliance_id    = alliance_change[1]          unless alliance_change.nil?
            item.alliance_tag   = alliance_tag_change[1]      unless alliance_tag_change.nil?
            item.alliance_color = alliance_color_change[1]    unless alliance_color_change.nil?
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
  
  def propagate_alliance_membership_changes_to_alliance_leader_vote
    alliance_change       = self.changes[:alliance_id]
    
    if !alliance_change.blank?
      Fundamental::AllianceLeaderVote.delete_all(["voter_id = ?", self.id])
      
      Fundamental::AllianceLeaderVote.where("candidate_id = ?", self.id).each do |v|
        v.candidate = v.voter
        v.save
      end
    end
    true
  end
  
  def propagate_insider_since_changes_to_chat
    if self.insider_since_changed?
      if self.insider_since.nil?
        cmd = Messaging::JabberCommand.revoke_access(self, 'insider')
        cmd.character_id = self.id
        cmd.save
      else
        cmd = Messaging::JabberCommand.grant_access(self, 'insider')
        cmd.character_id = self.id
        cmd.save
      end
    end
  end

  def propagate_alliance_membership_changes_to_resource_pool
    alliance_change     = self.changes[:alliance_id]
    unless alliance_change.nil?
      old_alliance = Fundamental::Alliance.find_by_id(alliance_change[0]) unless alliance_change[0].nil?
      new_alliance = Fundamental::Alliance.find_by_id(alliance_change[1]) unless alliance_change[1].nil?

      ActiveRecord::Base.transaction(:requires_new => true) do
        GameRules::Rules.the_rules.resource_types.each do |resource_type|

          old_bonus = old_alliance.nil? ? 0 : old_alliance[resource_type[:symbolic_id].to_s + '_production_bonus_effects']
          new_bonus = new_alliance.nil? ? 0 : new_alliance[resource_type[:symbolic_id].to_s + '_production_bonus_effects']

          pool_attribute = resource_type[:symbolic_id].to_s + '_production_bonus_alliance'

          self.resource_pool.lock!
          self.resource_pool.increment(pool_attribute, new_bonus - old_bonus)
          self.resource_pool.propagate_bonus_changes
          self.resource_pool.save!
        end
      end
    end
    true
  end

  def propagate_alliance_membership_changes_to_artifact
    alliance_change       = self.changes[:alliance_id]
    alliance_color_change = self.changes[:alliance_color]
    if (!alliance_change.nil? || !alliance_color_change.nil?) && !self.artifact.nil?
      self.artifact.alliance_id    = self.alliance_id
      self.artifact.alliance_color = self.alliance_color
      self.artifact.save
    end
    true
  end
  
  def propagate_alliance_bonus_to_alliance
    if self.alliance_size_bonus_changed? && !self.alliance.nil?
      self.alliance.recalculate_size_bonus
    end
  end

  # Function for propagating change of character name to redundant fields.
  # This uses update_all direct queries because the Rails way of looping
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
        set_clause[:updated_at]                        = DateTime.now

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
  
  
  # Function for propagating change of character name to redundant fields.
  # This uses update_all direct queries because the Rails way of looping
  # through models (selecting, instantiating, saving) would potentially take
  # too long (there might be several hundreds of settlements, locations and
  # armies involved).
  def propagate_avatar_changes
    propagate_avatar_string_on_change_only(true)
  end
  
  def propagate_avatar_string_on_change_only(on_change_only)
    avatar_change = self.changes[:avatar_string]
    
    redundancies = [
      { :model => Map::Location,             :field => :owner_id },
      { :model => Map::Region,               :field => :owner_id },
      { :model => Military::Army,            :field => :owner_id },      
      { :model => Ranking::CharacterRanking, :field => :character_id, :handlers_needed => true },
    ]
    
    if !avatar_change.blank? || !on_change_only
      
      new_string = self.avatar_string
      
      redundancies.each do |entry| 
        set_clause = { }
        set_clause[:avatar_string]   = new_string
        set_clause[:updated_at]      = DateTime.now

        if !entry[:handlers_needed].nil? && entry[:handlers_needed] == true
          entry[:model].where(entry[:field] => self.id).each do |item|
            item[:avatar_string]  = new_string         
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
  
  
  def propagate_kills_changes
    kills_change = self.changes[:kills]
    if !kills_change.nil?
      if !self.ranking.nil? && !self.ranking.frozen?
        self.ranking.kills = kills_change[1]
        self.ranking.save
      end
    end
    true
  end    
  
  def propagate_score_changes
    score_change = self.changes[:score]
    if !score_change.nil?
      if !self.ranking.nil? && !self.ranking.frozen? 
        self.ranking.overall_score = score_change[1]
        self.ranking.save
      end
    end
    true
  end
  
  def propagate_like_changes
    if self.received_likes_count_changed?
      if !self.ranking.nil? && !self.ranking.frozen?
        self.ranking.likes = received_likes_count || 0
        self.ranking.save
      end
      if !self.tutorial_state.nil?
        self.tutorial_state.check_for_new_quests('likes_count_trigger')
      end
    end
    true
  end
  
  def propagate_dislike_changes
    if self.received_dislikes_count_changed? && !self.ranking.nil? && !self.ranking.frozen?
      self.ranking.dislikes = received_dislikes_count || 0
      self.ranking.save
    end
    true
  end

  def propagate_victory_changes
    if victories_changed?
      if !self.ranking.nil? && !self.ranking.frozen?
        self.ranking.victories = victories || 0
        self.ranking.save
      end
      if !self.tutorial_state.nil?
        self.tutorial_state.check_for_new_quests('victories_count_trigger')
      end
    end
    true
  end
  
  def propagate_defeat_changes
    if defeats_changed? && !self.ranking.nil? && !self.ranking.frozen?
      self.ranking.defeats = defeats || 0
      self.ranking.save
    end
    true
  end

  def propagate_gender_changes
    if gender_changed? && !self.ranking.nil? && !self.ranking.frozen?
      self.ranking.gender = gender || 'male'
      self.ranking.save
    end
    true
  end

  def propagate_fortress_count_changes
    fortress_count_change = self.changes[:fortress_count]
    if !fortress_count_change.nil?
      if !self.ranking.nil? && !self.ranking.frozen?
        self.ranking.num_fortress = (self.ranking.num_fortress || 0) + (fortress_count_change[1] || 0) - (fortress_count_change[0] || 0)
        self.ranking.save
      end
    end
    true
  end

  def propagate_divine_supporter_changes
    divine_supporter_change = self.changes[:divine_supporter]
    if !divine_supporter_change.nil?
      self.locations.each do |location|
        location.set_special_image(self)
        location.save
      end
    end
    true
  end

  def propagate_image_set_changes
    image_set_change = self.changes[:image_set_id]
    if !image_set_change.nil?
      self.regions.each do |region|
        region.set_special_image(self)
        region.save
      end
    end
    true
  end

  def manage_assignments_on_level_change
    return true     unless assignment_level_changed?
    
    Assignment::StandardAssignment.manage_on_level_change(self, assignment_level_change[0], assignment_level_change[1])
  end
  
  def set_cannot_join_alliance_until
    round_started_at = Fundamental::RoundInfo.first.started_at

    if self.created_at > (GAME_SERVER_CONFIG['alliance_switch_allowed_after_registration'] || 20).days.ago
      self.cannot_join_alliance_until = Time.now
    else
      blocking_time = [(Time.now.to_date - round_started_at.to_date).to_i, (GAME_SERVER_CONFIG['alliance_switch_blocking_time'] || 14)].min
      self.cannot_join_alliance_until = blocking_time.days.from_now
    end

    # elsif self.created_at <= 20.days.ago && !self.alliance.is_at_war?
    #  self.cannot_join_alliance_until = 12.hours.from_now
    # elsif self.created_at <= 20.days.ago && self.alliance.is_at_war?
    #  self.cannot_join_alliance_until = 24.hours.from_now
    # end

    self.save
  end

  def join_alliance_check
    return false if self.alliance_id_changed? && self.alliance_id_was.nil? && !can_join_or_create_alliance?
  end

  def can_join_or_create_alliance?
    self.cannot_join_alliance_until.nil? || self.cannot_join_alliance_until < Time.now
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

    experience_production_rate = recalc_experience_production_rate
    check_and_apply_experience_production_rate(experience_production_rate)

    score_new = recalc_score
    check_and_apply_score(score_new)

    
    likes_count = recalc_likes_count
    check_and_apply_likes_count(likes_count)
    
    dislikes_count = recalc_dislikes_count
    check_and_apply_dislikes_count(dislikes_count)
    
    correct_alliance_size_bonus = recalc_alliance_size_bonus
    check_and_apply_alliance_size_bonus(correct_alliance_size_bonus)

    correct_assignment_level = recalc_assignment_level
    check_and_apply_assignment_level(correct_assignment_level)

    construction_bonus = recalc_construction_bonus_effect
    check_and_apply_construction_bonus_effect(construction_bonus)

    experience_bonus = recalc_experience_bonus_effect
    check_and_apply_experience_bonus_effect(experience_bonus)

    construction_bonus_alliance = recalc_construction_bonus_alliance
    check_and_apply_construction_bonus_alliance(construction_bonus_alliance)

    if self.changed?
      logger.warn(">>> SAVING CHARACTER AFTER DETECTING ERRORS.")
      self.save
    else
      logger.info(">>> CHARACTER OK.")
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
    present = self.construction_bonus_effect

    if (present - recalc).abs > 0.000001
      logger.warn(">>> CONSTRUCTION BONUS EFFECT RECALC DIFFERS. Old: #{present} Corrected: #{recalc}.")
      self.construction_bonus_effect = recalc
    end
  end

  def recalc_construction_bonus_alliance
    self.alliance.nil? ? 0 : self.alliance.construction_bonus_effects
  end

  def check_and_apply_construction_bonus_alliance(recalc)
    present = self.construction_bonus_alliance

    if (present - recalc).abs > 0.000001
      logger.warn(">>> CONSTRUCTION BONUS ALLIANCE RECALC DIFFERS. Old: #{present} Corrected: #{recalc}.")
      self.construction_bonus_alliance = recalc
    end
  end

  def recalc_and_apply_construction_bonus_alliance
    new_bonus = self.alliance.nil? ? 0 : self.alliance.construction_bonus_effects
    if new_bonus != self.construction_bonus_alliance
      self.construction_bonus_alliance = new_bonus
      self.save
    end
  end

  ############################################################################
  #
  #  P R E M I U M  A C C O U N T
  #
  ############################################################################  


  def extend_premium_atomically(duration)
    if self.premium_expiration.nil? || self.premium_expiration < Time.now
      self.premium_expiration = Time.now.advance(:hours => duration.to_i)
    else
      self.premium_expiration = self.premium_expiration.advance(:hours => duration.to_i)
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

  def check_for_new_quests_triggered_by_logged_in_on_second_day
    if self.logged_in_on_second_day_changed? && !self.tutorial_state.nil?
      self.tutorial_state.check_for_new_quests('logged_in_on_second_day_trigger')
    end
    true
  end

  def check_for_new_quests_triggered_by_mundane_rank
    if self.mundane_rank_changed? && !self.tutorial_state.nil?
      self.tutorial_state.check_for_new_quests('mundane_rank_trigger')
    end
    true
  end

  # ##########################################################################
  #
  #   Experience
  #
  # ##########################################################################
  
  def update_experience_if_necessary
    update_experience_amount_atomically if needs_experience_update?
  end
  
  
  def needs_experience_update?
    (self.production_updated_at || Time.now.advance(:hours => -2)) < Time.now.advance(:hours => -1)
  end
  
  def add_experience!(points)
    self.increment(:exp, (points * (1 + (self.exp_bonus_total || 0))).floor)
    self.save    
  end
  
  def increment_with_sql!(attribute, by = 1)
    raise ArgumentError("Invalid attribute: #{attribute}") unless attribute_names.include?(attribute.to_s)
    original_value_sql = "CASE WHEN #{attribute} IS NULL THEN 0 ELSE #{attribute} END"
    self.class.update_all("#{attribute} = #{original_value_sql} + #{by.to_i}", "id = #{id}")
    self.reload
  end

  def update_exp_production(old_mundane_rank, new_mundane_rank)
    if !self.artifact.nil? && self.artifact.initiated
      self.exp_production_rate -= artifact.experience_production(old_mundane_rank)
      self.exp_production_rate += artifact.experience_production(new_mundane_rank)
    end
  end

  def recalc_experience_production_rate
    exp_rate = 0.0
    self.settlements.each do |settlement|
      exp_rate += settlement.exp_production_rate
    end

    if self.artifact
      exp_rate += artifact.experience_production(self.mundane_rank)
    end
    exp_rate
  end

  def check_and_apply_experience_production_rate(experience_production_rate)
    if (self.exp_production_rate || 0) !=  experience_production_rate
      logger.warn(">>> CONSISTENCY ERROR: EXP PRODUCTION RATE RECALC DIFFERS for character #{self.id}. Old: #{self.exp_production_rate} Corrected: #{experience_production_rate}.")
      self.exp_production_rate = experience_production_rate
    end
  end

  # updates the resource amounts if the rate changes with this write
  def update_experience_on_production_rate_changes
    if self.exp_production_rate_changed?
      self.update_experience_amount_atomically
    end
    true
  end

  def recalc_experience_bonus_effect
    bonus = 0.0
    self.experience_effects.each do |effect|
      bonus += effect[:bonus] || 0.0
    end
    bonus
  end

  def check_and_apply_experience_bonus_effect(recalc)
    present = self.exp_bonus_effects

    if (present - recalc).abs > 0.000001
      logger.warn(">>> EXPERIENCE BONUS EFFECT RECALC DIFFERS. Old: #{present} Corrected: #{recalc}.")
      self.exp_bonus_effects = recalc
    end
  end

  def update_experience_on_bonus_changes
    if self.exp_bonus_total_changed?
      self.update_experience_amount_atomically
    end
    true
  end

  def update_experience_amount_atomically
    set_clauses = []
    set_clauses << "exp = exp + #{ Fundamental::Character.produced_experience_amount_sql_fragment('exp_production_rate', 'exp_bonus_total')}"
    set_clauses << "\"production_updated_at\" = #{ Fundamental::Character.now_sql_fragment }"
    set_clauses << "\"updated_at\" = #{ Fundamental::Character.now_sql_fragment }"
    Fundamental::Character.update_all(set_clauses.join(', ') , id: self.id) == 1 # affect exactly one row
  end
  
  def self.now_sql_fragment
    Rails.env.development? || Rails.env.test? ? 'datetime("now")' : 'NOW()'
  end
  
  def self.elapsed_time_sql_fragment
    if Rails.env.development? || Rails.env.test?
      return @elapsed_time_sql_fragment ||= "(strftime('%s', #{ Fundamental::Character.now_sql_fragment }) - strftime('%s', COALESCE(production_updated_at,  #{ Fundamental::Character.now_sql_fragment })))"
    else
      return @elapsed_time_sql_fragment ||= 'EXTRACT(EPOCH FROM (' + Fundamental::Character.now_sql_fragment + '-COALESCE("production_updated_at", ' + Fundamental::Character.now_sql_fragment + ')))'      
    end
  end
  
  def self.produced_experience_amount_sql_fragment(resource_field, bonus_field)
    "(#{Fundamental::Character.elapsed_time_sql_fragment} * (\"#{resource_field}\" * (1 + \"#{bonus_field}\") / 3600.0) )"
  end

  # ##########################################################################
  #
  #   Score
  #
  # ##########################################################################

  def recalc_score
    self.settlements.sum(:score)
  end
  
  def check_and_apply_score(new_score)
    if (self.score || 0) != new_score
      logger.warn(">>> CONSISTENCY ERROR: SCORE RECALC DIFFERS for character #{self.id}. Old: #{self.score} Corrected: #{new_score}.")
      self.score = new_score
    end
  end

  # ##########################################################################
  #
  #   Likes and Dislikes
  #
  # ##########################################################################

  def recalc_likes_count
    self.received_likes.count
  end
  
  def check_and_apply_likes_count(likes_count)
    if (self.received_likes_count || 0) != likes_count
      logger.warn(">>> CONSISTENCY ERROR: LIKES COUNT RECALC DIFFERS for character #{self.id}. Old: #{self.received_likes_count} Corrected: #{likes_count}.")
      self.received_likes_count = likes_count
    end
  end
  
  def recalc_dislikes_count
    self.received_dislikes.count
  end
  
  def check_and_apply_dislikes_count(dislikes_count)
    if (self.received_dislikes_count || 0) != dislikes_count
      logger.warn(">>> CONSISTENCY ERROR: DISLIKES COUNT RECALC DIFFERS for character #{self.id}. Old: #{self.received_dislikes_count} Corrected: #{dislikes_count}.")
      self.received_dislikes_count = dislikes_count
    end    
  end
  
  
  # ##########################################################################
  #
  #   Alliance Size Bonus
  #
  # ##########################################################################

  def recalc_alliance_size_bonus
    bonus = 0
    self.settlements.each do |settlement|
      bonus += (settlement.alliance_size_bonus || 0)
    end
    bonus
  end
  
  def check_and_apply_alliance_size_bonus(bonus)
    if (self.alliance_size_bonus || 0) != bonus
      logger.warn(">>> CONSISTENCY ERROR: ALLIANCE SIZE BONUS RECALC DIFFERS for character #{self.id}. Old: #{self.alliance_size_bonus} Corrected: #{bonus}.")
      self.alliance_size_bonus = bonus
    end
  end



  # ##########################################################################
  #
  #   Assignment Level
  #
  # ##########################################################################

  def recalc_assignment_level
    bonus = 0
    self.settlements.each do |settlement|
      bonus += (settlement.assignment_level || 0)
    end
    return bonus
  end
  
  def check_and_apply_assignment_level(bonus)
    if (self.assignment_level || 0) != bonus
      logger.warn(">>> CONSISTENCY ERROR: ASSIGNMENT LEVEL RECALC DIFFERS for character #{self.id}. Old: #{self.assignment_level} Corrected: #{bonus}.")
      self.assignment_level = bonus
    end
  end

  # ##########################################################################
  #
  #   DELETION OF CHARACTERS FROM GAME
  #
  # ##########################################################################

  def delete_from_game
    # hand over fortresses to npcs
    self.fortresses.each do |fortress|
      fortress.abandon_fortress
    end
    
    # hand over outposts to npcs
    self.outposts.each do |outpost|
      outpost.abandon_outpost
    end
    
    # hand over home settlement to npc
    self.home_location.settlement.abandon_base if !self.home_location.nil? && !self.home_location.settlement.nil?

    # move artifact to neighborhood
    self.artifact.jump_to_neighbor_location unless self.artifact.nil?
    
    # leave alliance
    self.alliance.remove_character(self) unless self.alliance.blank?
    
    # remove from character ranking
    # no need to recalc ranking as the renking will always be sorted on access
    self.ranking.destroy
    
    # remove tutorial state and quests (could be optional to avoid problems with stats)
    self.tutorial_state.quests.destroy unless self.tutorial_state.quests.nil?
    self.tutorial_state.destroy
    
    # delete retention_mails
    self.retention_mails.destroy_all
    self.last_retention_mail = nil
    
    # delete battle_results
    self.battle_results.destroy_all unless self.battle_results.nil?
    # armies are handled by settlement.remove_from_map
        
    # remove resource pool
    self.resource_pool.destroy
    
    # remove message box entries, message boxes and messages persist
    self.inbox.entries.destroy_all unless self.inbox.entries.nil?
    self.outbox.entries.destroy_all unless self.outbox.entries.nil?
    # self.archive.entries.destroy_all unless self.archive.entries.nil?
    
    # revoke access from chat rooms
    # cmd = Messaging::JabberCommand.revoke_access(self, 'global') 
    # cmd.character = self
    # cmd.save
    # cmd = Messaging::JabberCommand.revoke_access(self, 'handel') 
    # cmd.character = self
    # cmd.save
    # cmd = Messaging::JabberCommand.revoke_access(self, 'plauderhöhle') 
    # cmd.character = self
    # cmd.save
    # cmd = Messaging::JabberCommand.revoke_access(self, 'help') 
    # cmd.character = self
    # cmd.save
    
    # alle attribute löschen
    self.exp = 0
    self.skill_points = 0
    self.base_location_id = nil
    self.base_region_id = nil
    self.base_node_id = nil
    self.character_queue_research_unlock_count = 0
    self.character_unlock_diplomacy_count = 0
    self.character_unlock_alliance_creation_count = 0
    self.score = 0
    self.settlement_points_total = 1
    self.settlement_points_used = 0
    self.mundane_rank = 0
    self.sacred_rank = 0
    self.notified_mundane_rank = 0
    self.notified_sacred_rank = 0
    self.staff_roles = nil
    self.last_retention_mail_id = nil
    self.last_retention_mail_sent_at = nil
    self.kills = 0
    self.victories = 0
    self.defeats = 0
    self.fortress_count = 0
    self.exp_production_rate = 0.0
    self.exp_building_production_rate = 0.0
    self.production_updated_at = nil
    self.same_ip = nil?
    
    self.deleted_from_game = true
    self.last_deleted_at = Time.now
    self.save

    check_consistency
  end

  def removed_not_started
    self.armies.destroy_all

    self.claimed_locations.each do |location|
      location.claiming_character = nil
      location.save
    end

    self.deleted_from_game = true
    self.last_deleted_at = Time.now
    self.save
  end

  def first_start
    login_count.nil? || login_count < 1  || (!fb_player_id.blank? && login_count <= 2)
  end

  def beginner
    login_count.nil? || login_count <= 1 || (!fb_player_id.blank? && login_count <= 2)
  end

  # \deprecated : use insider? instead
  def insider
    !insider_since.nil? && insider_since < DateTime.now
  end
  
  def insider?
    !insider_since.nil? && insider_since < DateTime.now
  end

  def chat_beginner
    self.settlements.count < 2
  end

  def open_chat_pane
    login_count <= 3
  end

  def show_base_marker
    login_count < 10
  end

  def serializable_hash(options={})
    options[:only] = self.class.readable_attributes(options[:role]) unless options[:role].nil?
    options[:methods] = ['first_start', 'beginner', 'insider', 'chat_beginner', 'open_chat_pane', 'show_base_marker']
    options[:methods].push('lastactiv')  if options[:role] === :owner || options[:role] === :ally
    super(options)
  end


  # ##########################################################################
  #
  #   CONSTRUCTION EFFECTS
  #
  # ##########################################################################

  # adds a construction bonus effect to the character.
  def add_construction_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      amount = effect[:bonus]
      self.construction_bonus_effect = (self.construction_bonus_effect || 0.0) + amount
      self.save!
    end
  end

  # adds a construction bonus effect to the character.
  def remove_construction_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      amount = effect[:bonus]
      self.construction_bonus_effect = (self.construction_bonus_effect || 0.0) - amount
      self.save!
    end
  end

  def update_construction_bonus_total
    self.construction_bonus_total = self.construction_bonus_effect + self.construction_bonus_alliance
  end

  def propagate_construction_bonus
    if construction_bonus_total_changed?
      delta = (construction_bonus_total_change[1] || 0.0) - (construction_bonus_total_change[0] || 0.0)
      self.settlements.each do |settlement|
        GameRules::Rules.the_rules().queue_types.each do |queue_type|
          if queue_type[:category] == :queue_category_construction
            settlement.propagate_speedup_to_queue(:effects, queue_type, delta)
          end
        end
      end
    end
  end

  # ##########################################################################
  #
  #   EXPERIENCE EFFECTS
  #
  # ##########################################################################

  # adds a experience bonus effect to the character.
  def add_experience_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      amount = effect[:bonus]
      self.exp_bonus_effects = (self.exp_bonus_effects || 0.0) + amount
      self.save!
    end
  end

  # adds a experience bonus effect to the character.
  def remove_experience_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      amount = effect[:bonus]
      self.exp_bonus_effects = (self.exp_bonus_effects || 0.0) - amount
      self.save!
    end
  end

  def update_experience_bonus_total
    self.exp_bonus_total = self.exp_bonus_effects + self.exp_bonus_alliance
  end

  protected

  
    def advance_to_next_mundane_rank
      character_ranks              = GameRules::Rules.the_rules.character_ranks
      new_rank                     = (self.mundane_rank || 0) + 1
      skill_points_per_rank        = character_ranks[:skill_points_per_mundane_rank] || 0
      new_settlement_points        = character_ranks[:mundane][new_rank][:settlement_points] || 0

      self.update_exp_production(self.mundane_rank, new_rank)

      self.mundane_rank            = new_rank
      self.skill_points            = (self.skill_points || 0)            + skill_points_per_rank
      self.settlement_points_total = (self.settlement_points_total || 0) + new_settlement_points
    end
    
    
end


