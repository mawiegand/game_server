module GameState
  
  class Requirements

    # tests an array of grouped requirements. the requirements are met, if
    # all requirements of at least one group are all met (groups follow an
    # OR-logic, requirements inside a group are combined using AND).
    def self.meet_one_requirement_group?(requirementGroups, character, settlement, exclude_slot=nil)
      requirementGroups.each do | requirementGroup |
        return true   if self.meet_requirements?(requirementGroup, character, settlement, exclude_slot)
      end
      false
    end
    
    # tests a group (array) of requirements and returns true in case all are met.
    def self.meet_requirements?(requirements, character, settlement, exclude_slot=nil)
      met = true
      requirements.each do | requirement |
        case requirement[:type]
        when 'building'
          met = met && self.meet_building_requirement?(requirement, settlement, exclude_slot)  # does not execute the test, if another requirement already did fail
        end
      end
      met
    end
    
    def self.meet_building_requirement?(requirement, settlement, exclude_slot)
      
      slots = settlement.slots
      
      # logger.debug 'meet_building_requirement start'
      if !self.meet_requirement_min_level?(requirement, slots, exclude_slot)
        return false
      end
      
      # logger.debug 'meet_building_requirement after min'
      if !self.meet_requirement_max_level?(requirement, slots, exclude_slot)
        return false
      end
      
      # logger.debug 'meet_building_requirement after max'
      return true
    end
  
    # if at least one slot other than the slot to be excluded meets the 
    # minimum level requirement of a specific building id return true, 
    # otherwise return false
    def self.meet_requirement_min_level?(requirement, slots, exclude_slot)
      return true if !requirement[:min_level] || requirement[:min_level] <= 0 # a min level of zero or less is always true
      
      slots.each do |slot|
        if (exclude_slot.nil? || exclude_slot.slot_num != slot.slot_num) && slot.building_id == requirement[:id] && requirement[:min_level] && slot.level >= requirement[:min_level]
          return true
        end
      end
      return false
    end

    # if at least one slot doesn't meet the maximum level requirement of a 
    # specific building id return false, otherwise return true
    def self.meet_requirement_max_level?(requirement, slots, exclude_slot)
      return false if requirement[:max_level] && requirement[:max_level] < 0  ## a max-requirement smaller than zero cannot be true!
      
      slots.each do |slot|
        # TODO, IMPORTANT: vorgehen bei requirements diskutieren. Diese Lösung reicht unter Umständen nicht:
        # beim bauen (bauauftrag ausführen) reicht es, sollte beim queuen aber vielleicht auch gecheckt werden, was bereits im Bau ist ?
        # Falls ja: Lösungsvorschlag: im slot-model wird eine Funktion implementiert, die das Level nach Abschluss aller Jobs zurückliefert
        if (exclude_slot.nil? || exclude_slot.slot_num != slot.slot_num) && slot.building_id == requirement[:id] && requirement[:max_level] && slot.level > requirement[:max_level]
          return false
        end
      end
      return true
    end
  end
  
end