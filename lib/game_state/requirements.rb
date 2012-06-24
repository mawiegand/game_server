module GameState
  
  class Requirements
    
    def self.meet_requirements?(requirements, character, settlement)
      requirements.each do | requirement |
        case requirement[:type]
        when 'building'
          return self.meet_building_requirement?(requirement, settlement)
        # when 'science'
          # # current_character.meet_building_requirement(requirement)
        end
      end
    end
    
    def self.meet_building_requirement?(requirement, settlement)
      
      slots = settlement.slots
      
      # logger.debug 'meet_building_requirement start'
      if !self.meet_requirement_min_level?(requirement, slots)
        return false
      end
      
      # logger.debug 'meet_building_requirement after min'
      if !self.meet_requirement_max_level?(requirement, slots)
        return false
      end
      
      # logger.debug 'meet_building_requirement after max'
      return true
    end
  
    # if at least one slot meets the minimum level requirement of a specific building id return true, otherwise return false
    def self.meet_requirement_min_level?(requirement, slots)
      slots.each do |slot|
        if slot.building_id == requirement[:id] && requirement[:min_level] && slot.level >= requirement[:min_level]
          return true
        end
      end
      return false
    end

    # if at least one slot doesn't meet the maximum level requirement of a specific building id return false, otherwise return true
    def self.meet_requirement_max_level?(requirement, slots)
      slots.each do |slot|
        # TODO, IMPORTANT: vorgehen bei requirements diskutieren. Diese Lösung reicht unter Umständen nicht:
        # beim bauen (bauauftrag ausführen) reicht es, sollte beim queuen aber vielleicht auch gecheckt werden, was bereits im Bau ist ?
        # Falls ja: Lösungsvorschlag: im slot-model wird eine Funktion implementiert, die das Level nach Abschluss aller Jobs zurückliefert
        if slot.building_id == requirement[:id] && requirement[:max_level] && slot.level > requirement[:max_level]
          return false
        end
      end
      return true
    end
  end
  
end