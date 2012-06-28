require 'ticker/runloop'
require 'awe_native_extensions'
require 'ticker/battle_handler_message_factory'

class Ticker::BattleHandler
  
  def runloop 
    return @runloop 
  end
  
  def runloop=(arg)
    @runloop = arg
  end
  
  def event_type
    "military_battle"
  end
  
  def process_event(event)
    battle = Military::Battle.find(event.local_event_id)
    if battle.nil?
      #runloop.say "Could not find battle for id #{ event.local_event_id }.", Logger::ERROR
    else
      #switch off the garbage collection, to prevent the garbage collector marking not initialized SWIG obects
      gcstate = GC.disable

      #runloop.say "Process battle round #{ battle.battle_rounds_count || 0} for battle #{ battle.id } at loc #{ battle.location_id} in reg #{ battle.region_id }."
    
      ## create and fill the AWE battle
      awe_battle = Battle::Battle.new
      raise InternalServerError.new('Could not create an instance of Battle::Battle (awe_native_extension).') if awe_battle.nil?
      
      runloop.say "started filling awe_battle object"
      fill_awe_battle(battle, awe_battle)
      raise InternalServerError.new('BattleHandler failed to instantiate the battle from the persistent storage.') unless awe_battle.isValid 

      ## create the battle calculator object
      awe_battle_calculator = Battle::BattleCalculator.new
      raise InternalServerError.new('Could not create an instance of Battle::BattleCalculator (awe_native_extension).') if awe_battle_calculator.nil?

      ## calculate one battle round
      awe_battle_calculator.callculateOneTick(awe_battle)  # execute round
      
      ## extract and store results in database & handle retreat
      extract_results_from_awe_battle(awe_battle, battle)

      ## check if the battle is over
      if battle.battle_done?

        runloop.say "Battle done, starting to send out messages"

        ## generate message for participants
        generate_messages_for_battle(awe_battle, battle)

        #TODO CLEANUP

        #CALL: take-over-handler
        #        - decides, whether a takeover should happen (settlemenet involved & lost , winners still have a survivor)
        #        - decides, WHO should obtain the settlement (initiator; attacked first, otherwise the strongest winner)
        #        CALL: settlement.new_owner_transaction(character) with character of new owner

      else
        battle.create_event_for_next_round
      end
      
      #  LET ARMIES RETREAT AND CLEANUP PARTICIPANT AND ARMY
      
      # CONTINUE BATTLE?
      # YES: CREATE EVENT FOR NEXT ROUND
      # NO: CLEANUP PARTICIPANTS, FACTIONS AND BATTLE; RESET ARMIES
      
      runloop.say awe_battle.inspect
      
      runloop.say "Battle round completed, cleaning up and destroying event."      

      #reenable garbage collection if it was enabled before
      GC.enable unless gcstate

      runloop.say "WARNING event is currently not beeing destroyed for debug purposes"
      #event.destroy
      runloop.say "Battle handler completed."

    end
  end

  ## HANDLE RETREAT ##########################################################

  def handle_retreat_try(participant, participant_results)
    runloop.say "handeling retreat try"

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
      
      extract_results_from_awe_faction(awe_faction, faction, faction_results)

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

  def extract_results_from_awe_faction(awe_faction, faction, faction_results)
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

      if participant.army.battle_retreat
        handle_retreat_try(participant, participant_results)
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
  
  ## FILLING THE BATTLE STRUCTS ##############################################
  
  def create_awe_test_for(category)
    awe_priority_test = nil
    
    #puts 'CREATE TEST'

    if category[:target_priorities][:test_type] == :no_test          # NO TEST
      
      #puts 'CREATE NO TEST'
      
      awe_priority_test = Battle::NoTest.new
      category[:target_priorities][:results][0].each do | target |
        awe_priority_test.pushCategoryToPriority(target)
      end
      
    elsif category[:target_priorities][:test_type] == :line_size_test # LINE SIZE TEST
      
      #puts 'CREATE LINE SIZE TEST'
      
      awe_priority_test = Battle::LineSizeTest.new(category[:target_priorities][:test_category])
      category[:target_priorities][:results][0].each do | target |
        awe_priority_test.pushCategoryToPriorityOnSuccess(target)
      end   
      category[:target_priorities][:results][1].each do | target |
        awe_priority_test.pushCategoryToPriorityOnFail(target)
      end     
    end
    
    awe_priority_test
  end
  
  def fill_awe_battle(battle, awe_battle)
    # fill unit categories
    rules = GameRules::Rules.the_rules
    rules.unit_categories.each do | category |
      puts category.inspect
      awe_category = Battle::UnitCategory.new(category[:id])
      awe_category.categoryId = category[:id]
      awe_category.test = create_awe_test_for(category)
      awe_battle.addUnitCategory(awe_category)
    end
    
    #puts "finished categories"

    # fill factions
    battle.factions.each do |faction|
      awe_faction = Battle::Faction.new
      raise InternalServerError.new('could not create an instance of Battle::Faction (awe_native_extension).') if awe_faction.nil?
      
      fill_awe_faction(faction, awe_faction)
      awe_battle.addFaction(awe_faction)
    end
    
    #puts "finished factions"
    
    awe_battle
  end
  
  def fill_awe_faction(faction, awe_faction)
    faction.participants.each do |participant|

      awe_army = Battle::Army.new(participant.army.id)
      raise InternalServerError.new('could not create an instance of Battle::Army (awe_native_extension).') if awe_army.nil?
      unless participant.retreated
        fill_awe_army(participant, awe_army)
        awe_faction.addArmy(awe_army)
      end
    end
    
    awe_faction
  end
  
  
  def fill_awe_army(participant, awe_army)
    rules = GameRules::Rules.the_rules
    
    rules.unit_types.each do | unit_type |
      if !participant.army.details[unit_type[:db_field]].nil? && participant.army.details[unit_type[:db_field]] > 0
        awe_unit = Battle::Unit.new
        raise InternalServerError.new('could not create an instance of Battle::Unit (awe_native_extension).') if awe_unit.nil?
        
        fill_awe_unit(participant.army.details[unit_type[:db_field]], unit_type, awe_unit, participant.army.battle_retreat )
        awe_army.addUnit(awe_unit)

      end
    end
    
    awe_army
  end
  
  # expects the number of "soldiers" in the army, the unit_type (from the 
  # rules) and the awe object to be filled.
  #
  # TODO: here we need the owner as the army as well and must calculate all modified values (perhaps should be calculated inside Military::Army)
  def fill_awe_unit(number, unit_type, awe_unit, retreat)
    awe_unit.numUnitsAtStart = number
    awe_unit.unitTypeId = unit_type[:id]
	  #puts unit_type
    #awe_unit.unitCategoryId = 0 #  unit_type.id # must become a number!
    awe_unit.unitCategoryId = unit_type[:category]
    #if a army is retreating it does not deal any damage
    if retreat
      awe_unit.baseDamage = 0
      awe_unit.criticalDamage = 0
    else
      awe_unit.baseDamage = unit_type[:attack]
      awe_unit.criticalDamage = unit_type[:critical_hit_damage]
    end
    awe_unit.criticalProbability = unit_type[:critical_hit_chance]
    awe_unit.hitpoints = unit_type[:hitpoints]
    awe_unit.initiative = unit_type[:initiative]
    awe_unit.armor = unit_type[:armor]
    #effectiveness
    unit_type[:effectiveness].each {
      |s,e|
      cat_id = get_unit_category_id(s)
      awe_unit.setEffectivenessFor(cat_id, e)
    }
        
    awe_unit
  end

  def get_unit_category_id(category_symbol)
    rules = GameRules::Rules.the_rules
    rules.unit_categories.each {
      |c|
      if (c[:symbolic_id] == category_symbol)
        return c[:id]
      end
    } 
    raise InternalServerError.new('could not find the associated unit_category for a symbol.')
  end
  
end
