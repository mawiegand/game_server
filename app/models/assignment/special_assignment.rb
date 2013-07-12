class Assignment::SpecialAssignment < ActiveRecord::Base
  
  belongs_to :character,  :class_name => "Fundamental::Character",  :foreign_key => "character_id",  :inverse_of => :special_assignment

  # return current or new assignment if needed
  def self.updated_special_assignment_of_character(character)

    logger.debug "---> updated_special_assignment_of_character"

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
          logger.debug "---> return nil, idle assignment is active"
          nil
        else
          logger.debug "---> return current assignment"
          assignment
        end
      else
        logger.debug "---> return replaced assignment"
        assignment.replace_with_random_special_assignment
      end
    else
      logger.debug "---> return new assignment, no assignment object found"
      self.create_random_special_assignment(Time.now, character)
    end
  end

  # create new random assignment with specified start time
  def self.create_random_special_assignment(start_at, character)

    self.update_frequencies(character)

    random = Random.rand(1.0)
    logger.debug "---> create_random_special_assignment #{random}"

    start_at = Time.now if start_at.nil?

    if random > GameRules::Rules.the_rules.special_assignments[:idle_probability]
      # new random assignment
      new_assignment = self.new({
        character_id:     character.id,
        type_id:          self.random_type(character)[:id],
        displayed_until:  self.new_end_date(start_at, GameRules::Rules.the_rules.special_assignments[:idle_time])
      })
      new_assignment.add_values
      self.raise_fail_counters(character, new_assignment.type_id)
      new_assignment
    else
      # create dummy assignment
      self.create({
        character_id:     character.id,
        type_id:          -1,
        displayed_until:  self.new_end_date(start_at, GameRules::Rules.the_rules.special_assignments[:idle_time])
      })
      self.raise_fail_counters(character, -1)
      nil
    end
  end

  def self.raise_fail_counters(character, type_id)

    logger.debug "---> raise_fail_counters"

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
    GameRules::Rules.the_rules.special_assignment_types.select {|type| type[:level] <= character.assignment_level }
  end

  def self.random_type(character)

    random = Random.rand(1.0)
    logger.debug "---> random_type #{random}"

    # fill fail count array from frequencies
    sqrt_s_i_plus_1 = []
    Assignment::SpecialAssignmentFrequency.find_by_character(character).each do |frequency|
      sqrt_s_i_plus_1[frequency.type_id] = Math.sqrt(frequency.num_failed + 1)
    end

    # fill weights from game rules and calculate denominator
    w_i = []
    denominator = 0.0
    self.accessable_special_assignments(character).each do |assignment_type|
      id = assignment_type[:id]
      w_i[id] = assignment_type[:probability_factor]
      denominator += w_i[id] * sqrt_s_i_plus_1[id]
    end

    # calculate numerator and select type depending on a random number
    #random = Random.rand(1.0)
    numerator = 0.0
    self.accessable_special_assignments(character).each do |assignment_type|
      id = assignment_type[:id]
      numerator += w_i[id] * sqrt_s_i_plus_1[id]
      return assignment_type if random < numerator / denominator
    end

    # return first special assignment type, if randomizing fails
    self.accessable_special_assignments(character).first
  end

  def self.update_frequencies(character)

    logger.debug "---> update_frequencies"

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

    logger.debug "---> new_end_date"

    if start_at < Time.now
      start_at + ((Time.now - start_at) / duration).ceil * duration
    else
      start_at + duration
    end
  end

  def replace_with_random_special_assignment

    logger.debug "---> replace_with_random_special_assignment"

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
      formula = assignment_type[:costs][resource_type[:id]]
      if !formula.nil?
        cost_formula = Util::Formula.parse_from_formula(formula, 'PRODUCTION')
        self[resource_type[:symbolic_id].to_s + '_cost'] = cost_formula.apply(weighted_production_rate)
      end
    end

    # resource rewards
    resource_rewards = assignment_type[:rewards][:resource_rewards]
    if !resource_rewards.nil?
      resource_rewards.each do |resource_reward|
        reward_formula = Util::Formula.parse_from_formula(resource_reward[:amount], 'PRODUCTION')
        self[resource_reward[:resource].to_s + '_reward'] = reward_formula.apply(weighted_production_rate)
      end
    end

    # unit deposits
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      formula = assignment_type[:unit_deposits][unit_type[:id]]
      if !formula.nil?
        deposit_formula = Util::Formula.parse_from_formula(formula, 'PRODUCTION')
        self[unit_type[:db_field].to_s + '_deposit'] = deposit_formula.apply(weighted_production_rate)
      end
    end

    # unit rewards
    unit_rewards = assignment_type[:rewards][:unit_rewards]
    if !unit_rewards.nil?
      unit_rewards.each do |unit_reward|
        reward_formula = Util::Formula.parse_from_formula(unit_reward[:amount], 'PRODUCTION')
        self[unit_reward[:unit].to_s + '_reward'] = reward_formula.apply(weighted_production_rate)
      end
    end

    # experience reward
    formula = assignment_type[:rewards][:experience_reward]
    if !formula.nil?
      experience_reward_formula = Util::Formula.parse_from_formula(formula, 'PRODUCTION')
      self.experience_reward = experience_reward_formula.apply(weighted_production_rate)
    end

    self.save
  end

  def end_time

    logger.debug "---> end_time"

    return self.ended_at        if !self.ended_at.nil?
    return self.displayed_until if !self.displayed_until.nil?
    nil
  end

  def is_outdated?

    logger.debug "---> is_outdated?"

    if !self.end_time.nil?
      logger.debug "---> end_time #{self.end_time}"
      logger.debug "---> end_time #{ Time.now}"
      self.end_time < Time.now
    else
      false
    end
  end

end
