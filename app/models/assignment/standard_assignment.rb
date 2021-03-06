require 'game_state/rewards.rb'

class Assignment::StandardAssignment < ActiveRecord::Base
  
  belongs_to :character,  :class_name => "Fundamental::Character",  :foreign_key => "character_id",    :inverse_of => :standard_assignments
  has_one    :event,      :class_name => "Event::Event",            :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'standard_assignment'"

  has_many   :character_resource_effects, :class_name => "Effect::ResourceEffect",         :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_STANDARD_ASSIGNMENT_REWARD]
  has_many   :character_construction_effects, :class_name => "Effect::ConstructionEffect",         :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::ConstructionEffect::CONSTRUCTION_EFFECT_TYPE_STANDARD_ASSIGNMENT_REWARD]
  has_many   :character_experience_effects, :class_name => "Effect::ExperienceEffect",         :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::ExperienceEffect::EXPERIENCE_EFFECT_TYPE_STANDARD_ASSIGNMENT_REWARD]

  scope :with_type_id,  lambda { |type_id| where(:type_id => type_id) }
  scope :with_type,     lambda { |type|    where(:type_id => type[:id]) }
  
  after_save :manage_event_on_ended_at_change
  
  def self.manage_on_level_change(character, old_level, new_level)
    
    assignment_types = GameRules::Rules.the_rules.assignment_types
    assignment_types.each do |assignment_type|

      if assignment_type[:level] > old_level && assignment_type[:level] <= new_level
        # create corresponding assignment instance
        
        self.create_if_not_existing(character, assignment_type)
        
      elsif assignment_type[:level] <= old_level && assignment_type[:level] > new_level
        # destroy corresponding assignment instance
        
        self.destroy_if_existing(character, assignment_type)
      
      end
    end
  end
  
  def self.create_if_not_existing(character, type)
    assignment = character.standard_assignments.with_type(type).first
    if assignment.nil?
      assignment = character.standard_assignments.create({
        type_id: type[:id],
      })
    end
    assignment
  end
  
  def self.destroy_if_existing(character, type)
    assignment = character.standard_assignments.with_type(type).first
    unless assignment.nil?
      logger.info "Destroying assignment #{type[:id]} for character #{character.id}"
      assignment.destroy
    end
  end
  
  # returns the assignment type from the rules that corresponds to this assignment
  def assignment_type
    GameRules::Rules.the_rules.assignment_types[self.type_id || 0]
  end
  
  def hurried?
    !halved_at.nil?
  end
  
  def ongoing?
    !self.started_at.nil?
  end


  # ##########################################################################
  #
  #   PROCESSING COSTS, DEPOSITS, AND REWARDS
  #
  # ##########################################################################
  
  def resource_hash_from_rewards(resource_rewards)
    GameState::Rewards.resource_hash_from_rewards(resource_rewards)
  end
    
  def unit_hash_from_rewards(unit_rewards)
    GameState::Rewards.unit_hash_from_rewards(unit_rewards)
  end

  
  # ##########################################################################
  #
  #   STARTING, HALVING AND ENDING
  #
  # ##########################################################################
  

  # halves the duration of an ongoing assignment
  def speedup_now
    return         if self.started_at.nil?
    
    self.ended_at  = self.started_at.advance(:seconds => (self.assignment_type[:duration]).to_i / 2)
    self.halved_at = DateTime.now 
    self.halved_count += 1
  end
  
    
  # starts the assignment now, uses the duration as specified in the 
  # game rules and sets the start and end time appropriately
  def start_now
    return         if !self.started_at.nil?
    
    self.started_at = DateTime.now
    self.halved_at  = nil
    self.ended_at   = self.started_at.advance(:seconds => (self.assignment_type[:duration]).to_i)
    self.execution_count += 1
  end
  
  def costs
    costs = {}
    
    (assignment_type[:costs] || {}).each do |resource_id, formula|
      # f = Util::Formula.parse_from_formula(formula)
      costs[resource_id] = formula.to_f # f.apply(self.level_after)
    end
    
    costs
  end
  
  def unit_deposits
    deposit    = assignment_type[:unit_deposits]     
    return nil if deposit.nil?
    
    unit_types = GameRules::Rules.the_rules.unit_types
    result     = {}
    deposit.each do | unit_id, amount |
      unit_type = unit_types[unit_id]
      result[unit_type[:db_field]] = amount.to_i
    end
    
    result
  end
  
  def pay_for_assignment
    costs.nil? || self.character.resource_pool.remove_resources_transaction(self.costs)
  end
  
  def deposit_for_assignment
    deposits = self.unit_deposits
    garrison_army = self.character.home_location.garrison_army
    return false  if garrison_army.nil?
    deposits.nil? || (garrison_army.contains?(deposits) && garrison_army.reduce_units(deposits))   
  end
  
  def redeem_deposit
    deposits = self.unit_deposits
    garrison_army = self.character.home_location.garrison_army
    return false  if garrison_army.nil?
    deposits.nil? || garrison_army.add_units_safely(deposits)
  end    
  
  def pay_deposit_and_start_transaction
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      if !self.ongoing?
        if pay_for_assignment && deposit_for_assignment
          self.start_now
          self.save!
        else
          raise ForbiddenError.new "Could not start assignment due to lack of resources and / or units."
        end
      end
    end
  end
  
  def end_now
    self.started_at = nil
    self.halved_at = nil
    self.ended_at = nil
    self.finished = false
  end
  
  def redeem_rewards!
    rewards            = self.assignment_type[:rewards] || {}
    
    resource_rewards                    = rewards[:resource_rewards]
    unit_rewards                        = rewards[:unit_rewards]
    experience_rewards                  = rewards[:experience_reward]
    production_bonus_rewards            = rewards[:production_bonus_rewards]
    construction_bonus_rewards          = rewards[:construction_bonus_rewards]
    experience_production_bonus_rewards = rewards[:experience_production_bonus_rewards]

    resources = self.resource_hash_from_rewards(resource_rewards) 
    units = self.unit_hash_from_rewards(unit_rewards)
    
    if units.count > 0 
      garrison_army = self.character.home_location.garrison_army
      garrison_army.lock!

      # check if resources and units can be rewarded
      # Rails.logger.warning "Cannot redeem all assignment rewards as garrison is full." unless garrison_army.can_receive?(units)
      garrison_army.add_units_safely(units)
    end
    
    if resources.count > 0
      self.character.resource_pool.add_resources_transaction(resources) 
    end   
        
    unless experience_rewards.nil?
      self.character.increment(:exp, (rewards[:experience_reward] * (1 + (self.character.exp_bonus_total || 0))).floor)
      self.character.save!
    end

    unless production_bonus_rewards.nil?
      production_bonus_rewards.each do |production_bonus|
        resource_type_id = nil
        GameRules::Rules.the_rules().resource_types.each do |type|
          if type[:symbolic_id].to_s == production_bonus[:resource].to_s
            resource_type_id = type[:id]
            break
          end
        end
        raise BadRequestError.new("no resource type found for resource symbolic id #{production_bonus[:resource]}") if resource_type_id.nil?

        Effect::ResourceEffect.create_reward_effect(
            self.character,
            resource_type_id,
            production_bonus[:bonus],
            production_bonus[:duration],
            self.id,
            Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_STANDARD_ASSIGNMENT_REWARD
        )
      end
    end

    unless construction_bonus_rewards.nil?
      construction_bonus_rewards.each do |construction_bonus|
        Effect::ConstructionEffect.create_reward_effect(
            self.character,
            construction_bonus[:bonus],
            construction_bonus[:duration],
            self.id,
            Effect::ConstructionEffect::CONSTRUCTION_EFFECT_TYPE_STANDARD_ASSIGNMENT_REWARD
        )
      end
    end

    unless experience_production_bonus_rewards.nil?
      experience_production_bonus_rewards.each do |experience_production_bonus|
        Effect::ExperienceEffect.create_reward_effect(
            self.character,
            experience_production_bonus[:bonus],
            experience_production_bonus[:duration],
            self.id,
            Effect::ExperienceEffect::EXPERIENCE_EFFECT_TYPE_STANDARD_ASSIGNMENT_REWARD
        )
      end
    end
  end
  
  
  def redeem_rewards_deposit_and_end_transaction
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      if !self.ended_at.nil? && self.finished
        self.end_now
        self.save!
        self.redeem_rewards!
        if !self.redeem_deposit
          raise BadRequestError.new "Could not redeem deposit"
        end
      end
    end
  end

  def finish!
    if self.ongoing? && !self.ended_at.nil? && self.ended_at <= Time.now
      self.finished = true
      self.save!
    end
  end
  
  # ##########################################################################
  #
  #   MANAGING THE CORRSPONDING EVENT
  #
  # ##########################################################################

  # creates an event for the ongoing assignment
  def create_event
    if event.nil?
      event = self.build_event(
          character_id:   self.character_id,   # get current character id
          execute_at:     self.ended_at,
          event_type:     "standard_assignment",
          local_event_id: self.id,
      )
      if !self.save  # this is the final step; this makes sure, something is actually executed
        raise ArgumentError.new('could not create event for standard assignment')
      end
    end
    self.event
  end
  
  # updates the end time of the event corresponding to the ongoing assignment
  def update_event
    if self.event.nil?
      create_event  unless self.ended_at.nil?
    elsif self.ended_at == nil
      self.event.destroy
    else
      self.event.execute_at = self.ended_at
      self.event.save
    end
    event
  end
  
  
  
  protected
  
    def manage_event_on_ended_at_change
      return true    unless ended_at_changed?
      update_event
      true
    end
  
end
