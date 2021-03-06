class Assignment::SpecialAssignment < ActiveRecord::Base
  
  belongs_to :character,  :class_name => "Fundamental::Character",  :foreign_key => "character_id",  :inverse_of => :special_assignment
  has_one    :event,      :class_name => "Event::Event",            :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'special_assignment'"

  has_many   :character_resource_effects, :class_name => "Effect::ResourceEffect",         :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SPECIAL_ASSIGNMENT_REWARD]
  has_many   :character_construction_effects, :class_name => "Effect::ConstructionEffect",         :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::ConstructionEffect::CONSTRUCTION_EFFECT_TYPE_SPECIAL_ASSIGNMENT_REWARD]
  has_many   :character_experience_effects, :class_name => "Effect::ExperienceEffect",         :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::ExperienceEffect::EXPERIENCE_EFFECT_TYPE_SPECIAL_ASSIGNMENT_REWARD]

  after_save :manage_event_on_ended_at_change

  # return current or new assignment if needed
  def self.updated_special_assignment_of_character(character)

    # get current special assignment of character
    assignments = self.find_all_by_character_id(character.id)

    if !assignments.empty?
      assignment = assignments.first

      # if there are other assignments for this character, destroy them
      assignments[1..assignments.length].each do |old_assignment|
        old_assignment.destroy
      end
    end

    if !assignment.nil?
      if !assignment.is_outdated?
        if assignment.type_id < 0
          nil
        else
          assignment
        end
      else
        assignment.replace_with_random_special_assignment
      end
    else
      self.create_random_special_assignment(Time.now, character)
    end
  end

  # create new random assignment with specified start time
  def self.create_random_special_assignment(start_at, character)

    self.update_frequencies(character)

    random = Random.rand(1.0)

    start_at = Time.now if start_at.nil?

    if random > GameRules::Rules.the_rules.special_assignments[:idle_probability]
      # new random assignment
      random_type = self.random_type(character)

      if !random_type.nil?
        new_assignment = self.new({
          character_id:     character.id,
          type_id:          random_type[:id],
          displayed_until:  self.new_end_date(start_at, random_type[:display_duration]),
          seen_at:          Time.now
        })
        new_assignment.add_values
        self.raise_fail_counters(character, random_type[:id]  )
        new_assignment
      else
        # create dummy assignment
        self.create({
          character_id:     character.id,
          type_id:          -1,
          displayed_until:  self.new_end_date(start_at, GameRules::Rules.the_rules.special_assignments[:idle_time]),
          seen_at:          Time.now
        })
        self.raise_fail_counters(character, -1)
        nil
      end
    else
      # create dummy assignment
      self.create({
        character_id:     character.id,
        type_id:          -1,
        displayed_until:  self.new_end_date(start_at, GameRules::Rules.the_rules.special_assignments[:idle_time]),
        seen_at:          Time.now
      })
      self.raise_fail_counters(character, -1)
      nil
    end
  end

  def self.raise_fail_counters(character, type_id)
    # load all affected frequencies with one query
    frequencies = []
    Assignment::SpecialAssignmentFrequency.find_by_character(character).each do |frequency|
      frequencies[frequency.type_id] = frequency
    end

    # try to increment num_failed counter for each type
    self.accessable_special_assignments(character).each do |assignment_type|
      if type_id != assignment_type[:id]
        frequency = frequencies[assignment_type[:id]]

        # create new frequency object, if none exists
        if frequency.nil?
          Assignment::SpecialAssignmentFrequency.create({
              character_id: character.id,
              type_id:      type_id,
              num_failed:   1,
          })
        else
          frequency.num_failed += 1
          frequency.save
        end
      end
    end
  end

  def self.accessable_special_assignments(character)
    GameRules::Rules.the_rules.special_assignment_types.select do |type|
      type[:level] <= character.assignment_level && self.assignment_tests_fullfilled?(character, type)
    end
  end

  def self.random_type(character)

    random = Random.rand(1.0)

    # fill fail count array from frequencies
    sqrt_s_i_plus_1 = []
    Assignment::SpecialAssignmentFrequency.find_by_character(character).each do |frequency|
      sqrt_s_i_plus_1[frequency.type_id] = Math.sqrt(frequency.num_failed + 1)
    end

    accessable_special_assignments = accessable_special_assignments(character)

    # fill weights from game rules and calculate denominator
    w_i = []
    denominator = 0.0
    accessable_special_assignments.each do |assignment_type|
      id = assignment_type[:id]
      w_i[id] = assignment_type[:probability_factor]
      denominator += w_i[id] * sqrt_s_i_plus_1[id]
    end

    # calculate numerator and select type depending on a random number
    #random = Random.rand(1.0)
    numerator = 0.0
    accessable_special_assignments.each do |assignment_type|
      id = assignment_type[:id]
      numerator += w_i[id] * sqrt_s_i_plus_1[id]
      return assignment_type if random < numerator / denominator
    end

    # return first special assignment type, if randomizing fails
    accessable_special_assignments.first
  end

  def self.update_frequencies(character)
    # load all affected frequencies with one query
    frequencies = []
    Assignment::SpecialAssignmentFrequency.find_by_character(character).each do |frequency|
      frequencies[frequency.type_id] = frequency
    end

    # create missing frequencies
    self.accessable_special_assignments(character).each do |assignment_type|
      if frequencies[assignment_type[:id]].nil?
        Assignment::SpecialAssignmentFrequency.create({
          character_id: character.id,
          type_id:      assignment_type[:id],
          num_failed:   0,
        })
      end
    end
  end

  def self.new_end_date(start_at, duration)
    if start_at < Time.now
      start_at + ((Time.now - start_at) / duration).ceil * duration
    else
      start_at + duration
    end
  end

  def replace_with_random_special_assignment
    new_assignment = Assignment::SpecialAssignment::create_random_special_assignment(self.end_time, self.character)
    self.destroy
    new_assignment
  end

  def add_values
    assignment_type = GameRules::Rules.the_rules.special_assignment_types[self.type_id]
    return if assignment_type.nil?

    # calculat weighted_production_rate from resource pool (should move to resource pool)
    weighted_production_rate = 0;      # weighted according to rating_value of resource type. will be used in the ranking.
    GameRules::Rules.the_rules.resource_types.each do |resource_type|
      weighted_production_rate += self.character.resource_pool[resource_type[:symbolic_id].to_s + '_production_rate'] * (resource_type[:rating_value] || 0)
    end

    # resource costs
    GameRules::Rules.the_rules.resource_types.each do |resource_type|
      formula = assignment_type[:costs][resource_type[:id]] unless assignment_type[:costs].nil?
      if !formula.nil?
        cost_formula = Util::Formula.parse_from_formula(formula, 'PRODUCTION')
        self[resource_type[:symbolic_id].to_s + '_cost'] = cost_formula.apply(weighted_production_rate)
      end
    end

    # resource rewards
    resource_rewards = assignment_type[:rewards][:resource_rewards] unless assignment_type[:rewards].nil?
    if !resource_rewards.nil?
      resource_rewards.each do |resource_reward|
        reward_formula = Util::Formula.parse_from_formula(resource_reward[:amount], 'PRODUCTION')
        self[resource_reward[:resource].to_s + '_reward'] = reward_formula.apply(weighted_production_rate)
      end
    end

    # unit deposits
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      formula = assignment_type[:unit_deposits][unit_type[:id]] unless assignment_type[:unit_deposits].nil?
      if !formula.nil?
        deposit_formula = Util::Formula.parse_from_formula(formula, 'PRODUCTION')
        self[unit_type[:db_field].to_s + '_deposit'] = deposit_formula.apply(weighted_production_rate)
      end
    end

    # unit rewards
    unit_rewards = assignment_type[:rewards][:unit_rewards] unless assignment_type[:rewards].nil?
    if !unit_rewards.nil?
      unit_rewards.each do |unit_reward|
        reward_formula = Util::Formula.parse_from_formula(unit_reward[:amount], 'PRODUCTION')
        self[unit_reward[:unit].to_s + '_reward'] = reward_formula.apply(weighted_production_rate)
      end
    end

    # experience reward
    formula = assignment_type[:rewards][:experience_reward] unless assignment_type[:rewards].nil?
    if !formula.nil?
      experience_reward_formula = Util::Formula.parse_from_formula(formula, 'PRODUCTION')
      self.experience_reward = experience_reward_formula.apply(weighted_production_rate)
    end

    self.save
  end

  def end_time
    return self.ended_at        if !self.ended_at.nil?
    return self.displayed_until if !self.displayed_until.nil?
    nil
  end

  def is_outdated?
    return false if self.finished
    if !self.end_time.nil?
      self.end_time < Time.now
    else
      false
    end
  end

  # returns the assignment type from the rules that corresponds to this assignment
  def assignment_type
    GameRules::Rules.the_rules.special_assignment_types[self.type_id || 0]
  end

  def hurried?
    !halved_at.nil?
  end

  def ongoing?
    !self.started_at.nil?
  end


  # ##########################################################################
  #
  #   STARTING, HALVING AND ENDING
  #
  # ##########################################################################


  # halves the duration of an ongoing assignment
  def speedup_now
    return         if self.started_at.nil?

    self.ended_at         = self.started_at.advance(:seconds => (self.assignment_type[:duration]).to_i / 2)
    self.displayed_until  = self.ended_at
    self.halved_at        = DateTime.now
  end


  # starts the assignment now, uses the duration as specified in the
  # game rules and sets the start and end time appropriately
  def start_now
    return         if !self.started_at.nil?

    self.started_at       = DateTime.now
    self.halved_at        = nil
    self.ended_at         = self.started_at.advance(:seconds => (self.assignment_type[:duration]).to_i)
    self.displayed_until  = self.ended_at
    self.execution_count += 1

    reset_frequency
  end

  def reset_frequency
    frequency = Assignment::SpecialAssignmentFrequency.find_by_character_id_and_type_id(self.character_id, self.type_id)
    frequency.destroy unless frequency.nil?
  end



  def costs
    costs = {}
    GameRules::Rules.the_rules.resource_types.each do |resource_type|
      resource_cost = self[resource_type[:symbolic_id].to_s + '_cost']
      costs[resource_type[:id]] = resource_cost if !resource_cost.nil? && resource_cost > 0
    end
    costs
  end

  def unit_deposits
    result     = {}
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      unit_deposit = self[unit_type[:db_field].to_s + '_deposit']
      result[unit_type[:db_field]] = unit_deposit if !unit_deposit.nil? && unit_deposit > 0
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
    self.displayed_until = Time.now
    self.finished = false
  end

  def redeem_rewards!
    rewards            = self.assignment_type[:rewards] || {}

    production_bonus_rewards            = rewards[:production_bonus_rewards]
    construction_bonus_rewards          = rewards[:construction_bonus_rewards]
    experience_production_bonus_rewards = rewards[:experience_production_bonus_rewards]

    resource_rewards = {}
    GameRules::Rules.the_rules.resource_types.each do |resource_type|
      resource_reward = self[resource_type[:symbolic_id].to_s + '_reward']
      resource_rewards[resource_type[:id]] = resource_reward if !resource_reward.nil? && resource_reward > 0
    end

    unit_rewards = {}
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      unit_reward = self[unit_type[:db_field].to_s + '_reward']
      unit_rewards[unit_type[:db_field]] = unit_reward if !unit_reward.nil? && unit_reward > 0
    end

    experience_reward = self[:experience_reward]

    if resource_rewards.count > 0
      self.character.resource_pool.add_resources_transaction(resource_rewards)
    end

    if unit_rewards.count > 0
      garrison_army = self.character.home_location.garrison_army
      garrison_army.lock!

      # check if resources and units can be rewarded
      # Rails.logger.warning "Cannot redeem all assignment rewards as garrison is full." unless garrison_army.can_receive?(units)
      garrison_army.add_units_safely(unit_rewards)
    end

    unless experience_reward.nil?
      self.character.increment(:exp, (experience_reward * (1 + (self.character.exp_bonus_total || 0))).floor)
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
            Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_SPECIAL_ASSIGNMENT_REWARD
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
            Effect::ConstructionEffect::CONSTRUCTION_EFFECT_TYPE_SPECIAL_ASSIGNMENT_REWARD
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
            Effect::ExperienceEffect::EXPERIENCE_EFFECT_TYPE_SPECIAL_ASSIGNMENT_REWARD
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
          event_type:     "special_assignment",
          local_event_id: self.id,
      )
      if !self.save  # this is the final step; this makes sure, something is actually executed
        raise ArgumentError.new('could not create event for special assignment')
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

  # ##########################################################################
  #
  #   ASSIGNMENT TESTS
  #
  # ##########################################################################

  def self.assignment_tests_fullfilled?(character, assignment_type)

    return false if assignment_type.nil?

    # reward tests durchtesten
    assignment_tests = assignment_type[:assignment_tests]

    if !assignment_tests.nil?

      unless assignment_tests[:resource_production_tests].nil?
        assignment_tests[:resource_production_tests].each do |resource_production_test|
          unless self.check_resource_production(character, resource_production_test)
            return false
          end
        end
      end

      unless assignment_tests[:building_tests].nil?
        assignment_tests[:building_tests].each do |building_test|
          unless building_test.nil?
            unless self.check_buildings(character, building_test)
              return false
            end
          end
        end
      end

      unless assignment_tests[:settlement_tests].nil?
        assignment_tests[:settlement_tests].each do |settlement_test|
          unless settlement_test.nil?
            unless self.check_settlements(character, settlement_test)
              return false
            end
          end
        end
      end

      unless assignment_tests[:army_tests].nil?
        assignment_tests[:army_tests].each do |army_test|
          unless army_test.nil?
            unless self.check_armies(character, army_test)
              return false
            end
          end
        end
      end

      unless assignment_tests[:construction_queue_tests].nil?
        assignment_tests[:construction_queue_tests].each do |construction_queue_test|
          unless construction_queue_test.nil?
            unless self.check_construction_queues(charcter, construction_queue_test)
              unless self.check_buildings(character, construction_queue_test)
                return false
              end
            end
          end
        end
      end

      unless assignment_tests[:training_queue_tests].nil?
        assignment_tests[:training_queue_tests].each do |training_queue_test|
          unless training_queue_test.nil?
            unless self.check_training_queues(character, training_queue_test)
              return false
            end
          end
        end
      end

      unless assignment_tests[:movement_test].nil?
        movement_test = assignment_tests[:movement_test]
        unless movement_test.nil?
          unless self.check_movements(character)
            return false
          end
        end
      end

      unless assignment_tests[:alliance_test].nil?
        alliance_test = assignment_tests[:alliance_test]
        unless alliance_test.nil?
          unless self.check_alliance(character)
            return false
          end
        end
      end

      unless assignment_tests[:kill_test].nil?
        kill_test = assignment_tests[:kill_test]
        unless self.check_kills(character, kill_test)
          return false
        end
      end

      unless assignment_tests[:battle_test].nil?
        unless self.check_battle(character)
          return false
        end
      end

      unless assignment_tests[:army_experience_test].nil?
        army_experience_test = assignment_tests[:army_experience_test]
        unless self.check_army_experience(character, army_experience_test)
          return false
        end
      end

      unless assignment_tests[:score_test].nil?
        score_test = assignment_tests[:score_test]
        unless self.check_score(character, score_test)
          return false
        end
      end

      unless assignment_tests[:settlement_production_test].nil?
        settlement_production_test = assignment_tests[:settlement_production_test]
        unless self.check_settlement_production(character, settlement_production_test)
          return false
        end
      end

      unless assignment_tests[:building_speed_test].nil?
        building_speed_test = assignment_tests[:building_speed_test]
        unless self.check_building_speed(character, building_speed_test)
          return false
        end
      end
    else
      logger.debug 'no reward tests found'
    end
    true
  end


  def self.check_resource_production(character, test)
    pool = character.resource_pool
    return false    if pool.nil?

    symbol = test[:resource].to_s + '_production_rate'

    (pool[symbol.to_sym] || 0) >= (test[:minimum] || 0).to_f
  end

  def self.check_buildings(character, building_test)
    # check for min count and min level
    return false if building_test[:min_count].nil? || building_test[:min_level].nil?

    #check for building type
    building_type = nil
    GameRules::Rules.the_rules.building_types.each do |type|
      if type[:symbolic_id].to_s == building_test[:building].to_s
        building_type = type
        break
      end
    end
    return false if building_type.nil?

    logger.debug "check_buildings: check if min #{building_test[:min_count]} buildings of type '#{building_test[:building]}' with min level #{building_test[:min_level]} exists"

    # count slots that meet the requirements of building_test.
    # return true, if there are enough buildings.
    check_count = 0
    character.settlements.each do |settlement|
      unless settlement.slots.nil?
        settlement.slots.each do |slot|
          if !slot.level.nil? &&
              !slot.building_id.nil? &&
              building_type[:id] == slot.building_id &&
              slot.level >= building_test[:min_level]
            check_count += 1
            if check_count >= building_test[:min_count]
              return true
            end
          end
        end
      end
    end

    # building check failed, if method reaches this point
    false
  end

  def self.check_settlements(character, settlement_test)
    # check for min count and type
    return false if settlement_test[:min_count].nil? || settlement_test[:type].nil?

    logger.debug "check_settlements: check if min #{settlement_test[:min_count]} settlements of type #{settlement_test[:type]} exists"

    settlement_type = nil
    GameRules::Rules.the_rules.settlement_types.each do |type|
      if type[:symbolic_id].to_s == settlement_test[:type].to_s
        settlement_type = type
        break
      end
    end
    return false if settlement_type.nil?

    settlements = character.settlements.where({type_id: settlement_type[:id]})
    !settlements.nil? && settlements.count >= settlement_test[:min_count]
  end

  def self.check_armies(character, army_test)
    # check for min count and min level
    return false if army_test[:min_count].nil? || army_test[:type].nil?

    logger.debug "check_armies: check if min #{army_test[:min_count]} armies of army type '#{army_test[:type]}' exists"

    army_count = 0
    character.armies.each do |army|
      if (army.garrison? && army_test[:type].to_s == 'garrison' ||
          !army.garrison? && army_test[:type].to_s == 'visible') &&
          !army.size_present.nil? && army.size_present > 0
        army_count += (army.size_present || 0)
      end
    end

    army_count >= army_test[:min_count]
  end

  def self.check_construction_queues(character, queue_test)
    # check for min count
    return false if queue_test[:min_count].nil? || queue_test[:min_level].nil?

    #check for building type
    building_type = nil
    GameRules::Rules.the_rules.building_types.each do |type|
      if type[:symbolic_id].to_s == queue_test[:building].to_s
        building_type = type
        break
      end
    end
    return false if building_type.nil?

    logger.debug "check_construction_queues: check if min #{queue_test[:min_count]} buildings of type '#{queue_test[:building]}' are queued"

    # count jobs that meet the requirements of queue_test.
    # return true, if there are enough jobs.
    check_count = 0
    character.settlements.each do |settlement|
      unless settlement.queues.nil?
        settlement.queues.each do |queue|
          unless queue.jobs.nil?
            queue.jobs.each do |job|
              if building_type[:id] === job.building_id &&
                  (job.job_type == Construction::Job::TYPE_CREATE || job.job_type == Construction::Job::TYPE_UPGRADE) &&
                  job.level_after >= queue_test[:min_level]
                check_count += 1
                if check_count >= queue_test[:min_count]
                  return true
                end
              end
            end
          end
        end
      end

      unless settlement.slots.nil?
        settlement.slots.each do |slot|
          if !slot.level.nil? &&
              !slot.building_id.nil? &&
              building_type[:id] == slot.building_id &&
              slot.level >= queue_test[:min_level]
            check_count += 1
            if check_count >= queue_test[:min_count]
              return true
            end
          end
        end
      end
    end

    # queue check failed, if method reaches this point
    false
  end

  def self.check_training_queues(character, queue_test)
    # check for min count
    return false if queue_test[:min_count].nil?

    #check for building type
    unit_type = nil
    GameRules::Rules.the_rules.unit_types.each do |type|
      if type[:db_field].to_s == queue_test[:unit].to_s
        unit_type = type
        break
      end
    end
    return false if unit_type.nil?

    logger.debug "check_training_queues check if min #{queue_test[:min_count]} units of type '#{queue_test[:unit]}' are queued"

    # count jobs that meet the requirements of queue_test.
    # return true, if there are enough jobs.
    check_count = 0
    character.settlements.each do |settlement|
      unless settlement.training_queues.nil?
        settlement.training_queues.each do |queue|
          unless queue.jobs.nil?
            queue.jobs.each do |job|
              if unit_type[:id] === job.unit_id
                check_count += 1
                if check_count >= queue_test[:min_count]
                  return true
                end
              end
            end
          end
        end
      end
    end

    # queue check failed, if method reaches this point
    false
  end

  def self.check_movements(character)
    armies = character.armies
    if armies.nil?
      false
    else
      armies.where(mode: Military::Army::MODE_MOVING).count > 0
    end
  end

  def self.check_alliance(character)
    !character.alliance.nil?
  end

  def self.check_kills(character, kill_test)
    return false if kill_test[:min_units].nil?

    logger.debug "check_kills: check if min #{kill_test[:min_units]} units are already killed"

    character.kills >= kill_test[:min_units]
  end

  def self.check_battle(character)
    logger.debug "check_battle: check if min 1 unit is fighting"
    armies = character.armies
    if armies.nil?
      false
    else
      armies.where(mode: Military::Army::MODE_FIGHTING).count > 0 || character.kills > 0
    end
  end

  def self.check_army_experience(character, army_experience_test)
    return false if army_experience_test[:min_experience].nil?

    logger.debug "check_army_experience: check if one army has at least #{army_experience_test[:min_experience]} XP"

    character.armies.each do |army|
      return true if army.exp >= army_experience_test[:min_experience]
    end
    false
  end

  def self.check_score(character, score_test)
    return false if score_test[:min_population].nil?

    logger.debug "check_score: check if a min score of #{score_test[:min_population]} is already reached"

    character.score >= score_test[:min_population]
  end

  def self.check_settlement_production(character, settlement_production_test)
    return false if settlement_production_test[:min_resources].nil?

    logger.debug "check_settlement_production: check if one settlement has at least a weighted resource production of #{settlement_production_test[:min_resources]} "

    production_test_weights = Tutorial::Tutorial.the_tutorial.production_test_weights

    character.settlements.each do |settlement|
      resources = 0.0
      GameRules::Rules.the_rules.resource_types.each do |type|
        resources += settlement[type[:symbolic_id].to_s + '_production_rate'] * (production_test_weights[type[:symbolic_id].to_sym] || 0)
      end
      return true if resources >= settlement_production_test[:min_resources]
    end

    false
  end

  def self.check_building_speed(character, building_speed_test)
    return false if building_speed_test[:min_speed].nil?

    logger.debug "check_building_speed: check if home settlement has at least a building queue speed of #{building_speed_test[:min_speed]}"

    building_queues = character.home_location.settlement.queues

    building_queues.each do |queue|
      return true if queue.speed >= building_speed_test[:min_speed]
    end

    false
  end


  protected

    def manage_event_on_ended_at_change
      return true    unless ended_at_changed?
      update_event
      true
    end

end
