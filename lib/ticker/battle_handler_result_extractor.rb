require 'ticker/runloop'
require 'awe_native_extensions'

class Ticker::BattleHandler

  def runloop 
    return @runloop 
  end

  ## HANDLE RETREAT ##########################################################

  def handle_retreat_try(battle, participant, participant_results)
    runloop.say "handeling retreat try"
    #mark that there was a try
    participant_results.retreat_succeeded = false

    #check if there is position that the army can retreat to
    retreat_locations = []

    if battle.location.fortress?
      #get neighbors
      neighbor_nodes = battle.region.node.neighbor_nodes
      #check the fortresses of the neighbor nodes
      neighbor_nodes.each do |n|
        location = n.region.fortress_location
        if location.can_be_retreated_to(participant.army.owner)
          retreat_locations.push location
        end
      end
    else
      #check the fortress
      fortress_location = battle.region.fortress_location
      if fortress_location.can_be_retreated_to?(participant.army.owner)
        retreat_locations.push fortress_location
      end
    end

    #shuffle the possible location
    retreat_locations.shuffle!

    #now do a random experiment for every location
    random = Random.new
    rules = GameRules::Rules.the_rules
    retreat_probability = rules.battle[:calculation][:retreat_probability]

    retreat_locations.each do |target|
    	if random.rand < retreat_probability
    		#found a location to retreat to
    		participant_results.retreat_succeeded = true
    		participant.retreated = true;
    		participant.retreated_to_region_id = target.region.id
    		participant.retreated_to_location_id = target.id
    		if !participant.save
        		raise InternalServerError.new('Server could not save a successfull retreat of a battle participant in persistant storage.')
      		end
    		return true
    	end
    end
    return false
  end
  
  ## EXTRACTING RESULTS FROM BATTLE STRUCTS ##################################

  def extract_results_from_awe_battle(awe_battle, battle)
    round = battle.rounds.build(
      :round_num   => battle.battle_rounds_count || 0,
      :executed_at => battle.next_round_at
    )
    if !round.save 
      raise InternalServerError.new('Server could not create a new battle round in persistant storage.');
    end
    
    (0..(awe_battle.numFactions-1)).each do | f |
      awe_faction = awe_battle.getFaction(f)
      faction = battle.factions[f]
      faction_results = round.faction_results.build(
        :battle_id => battle.id,
        :faction_id => faction.id,
        :leader_id => faction.leader_id,
        :given_command => faction.present_command,
        :executed_command => nil,
      )
      if !faction_results.save
        raise InternalServerError.new('Server could not create a new result for a battle faction in persistant storage.')
      end
      
      extract_results_from_awe_faction(battle, awe_faction, faction, faction_results)

      #update the factions itself
      faction.total_casualties = 0 if (faction.total_casualties.nil?)
      faction.total_casualties = faction.total_casualties + awe_faction.getTotalCasualties
      faction.total_kills = 0 if (faction.total_kills.nil?)
      faction.total_kills = faction.total_kills + awe_faction.getTotalKills
      faction.total_damage_inflicted = 0 if (faction.total_damage_inflicted.nil?)
      faction.total_damage_inflicted = faction.total_damage_inflicted + awe_faction.getTotalDamageInflicted
      faction.total_damage_taken = 0 if (faction.total_damage_taken.nil?)
      faction.total_damage_taken = faction.total_damage_taken + awe_faction.getTotalDamageTaken
      faction.total_hitpoints = 0 if (faction.total_hitpoints.nil?)
      faction.total_hitpoints = awe_faction.getTotalHitpoints
      if !faction.save
        raise InternalServerError.new('Server could not update a battle faction.')
      end
      
    end       
  
    battle
  end

  def extract_results_from_awe_faction(battle, awe_faction, faction, faction_results)
    current_participant_index = -1
    (0..(awe_faction.numArmies-1)).each do | a |
      awe_army = awe_faction.getArmy(a)
      #get the participant
      participant = nil
      begin
        current_participant_index += 1
        raise InternalServerError('Could not match the awe army to a military_battle_participant') if current_participant_index >= faction.participants.length
        participant = faction.participants[current_participant_index]
      end while participant.retreated
      #extract
      participant[:total_experience_gained] = participant[:total_experience_gained] + awe_army.sumNewExp
      participant_results = faction_results.participant_results.build(
        :battle_id => faction.battle_id,
        :round_id => faction_results.round.id,
        :battle_faction_result_id => faction_results.id,             # TODO: add faction to database, rename this field (strip battle_)
        :army_id => participant.army.id,
        :kills => awe_army.numKills,
        :experience_gained => awe_army.sumNewExp,
      )
      extract_results_from_awe_participant(awe_army, participant, participant_results)

      #handle the possible retreat
      if participant.army.battle_retreat
        participant_results.retreat_tried = true
        handle_retreat_try(battle, participant, participant_results)
      else
        participant_results.retreat_tried = false
      end

      if !participant_results.save
        raise InternalServerError.new('Server could not create a new result for a battle participant in persistant storage.')
      end
      
    end
    
    faction_results
  end
  
  def extract_results_from_awe_participant(awe_army, participant, participant_results)
    rules = GameRules::Rules.the_rules
    
    #set everything 0 first
    rules.unit_types.each do | unit_type |
      participant_results[unit_type[:db_field]] = 0
      participant_results[(unit_type[:db_field].to_s+'_casualties').to_sym] = 0
      participant_results[(unit_type[:db_field].to_s+'_damage_taken').to_sym] = 0
      participant_results[(unit_type[:db_field].to_s+'_damage_inflicted').to_sym] = 0
    end

    #insert the real data
    (0..(awe_army.numUnits-1)).each do | u |
      awe_unit = awe_army.getUnit(u)
      unit_type = rules.unit_types[awe_unit.unitTypeId]
      
      participant_results[unit_type[:db_field]] = awe_unit.numUnitsAtStart
      participant_results[(unit_type[:db_field].to_s+'_casualties').to_sym] = awe_unit.numDeaths
      participant_results[(unit_type[:db_field].to_s+'_damage_taken').to_sym] = awe_unit.damageTaken
      participant_results[(unit_type[:db_field].to_s+'_damage_inflicted').to_sym] = awe_unit.damageInflicted

    end

    # update survivors on army
    participant.army.reduce_units(participant_results.get_unit_reduce_hash)
  end

end