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
      new_assignment = self.create({
        character_id:     character.id,
        type_id:          self.random_type(character)[:id],
        displayed_until:  self.new_end_date(start_at, GameRules::Rules.the_rules.special_assignments[:idle_time])
      })
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
    GameRules::Rules.the_rules.special_assignment_types.each do |assignment_type|
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
    GameRules::Rules.the_rules.special_assignment_types.each do |assignment_type|
      id = assignment_type[:id]
      w_i[id] = assignment_type[:probability_factor]
      denominator += w_i[id] * sqrt_s_i_plus_1[id]
    end

    # calculate numerator and select type depending on a random number
    #random = Random.rand(1.0)
    numerator = 0.0
    GameRules::Rules.the_rules.special_assignment_types.each do |assignment_type|
      id = assignment_type[:id]
      numerator += w_i[id] * sqrt_s_i_plus_1[id]
      return assignment_type if random < numerator / denominator
    end

    # return first special assignment type, if randomizing fails
    GameRules::Rules.the_rules.special_assignment_types.first
  end

  def self.update_frequencies(character)

    logger.debug "---> update_frequencies"

    # load all affected frequencies with one query
    frequencies = []
    Assignment::SpecialAssignmentFrequency.find_by_character(character).each do |frequency|
      frequencies[frequency.type_id] = frequency
    end

    # create missing frequencies
    GameRules::Rules.the_rules.special_assignment_types.each do |assignment_type|
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
