require 'ticker/runloop'
require 'awe_native_extensions'

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
      #runloop.say "Process battle round #{ battle.battle_rounds_count || 0} for battle #{ battle.id } at loc #{ battle.location_id} in reg #{ battle.region_id }."
    
      ## create and fill the AWE battle
      awe_battle = Battle::Battle.new
      raise InternalServerError.new('Could not create an instance of Battle::Battle (awe_native_extension).') if awe_battle.nil?
      
      fill_awe_battle(battle, awe_battle)
      raise InternalServerError.new('BattleHandler failed to instantiate the battle from the persistent storage.') unless awe_battle.isValid 

      ## create the battle calculator object
      awe_battle_calculator = Battle::BattleCalculator.new
      raise InternalServerError.new('Could not create an instance of Battle::BattleCalculator (awe_native_extension).') if awe_battle_calculator.nil?

      ## calculate one battle round
      awe_battle_calculator.callculateOneTick(awe_battle)  # execute round
      
      # extract and store results in database
      extract_results_from_awe_battle(awe_battle, battle)
      
      #  EXTRACT RESULTS (FACTION AND PARTICIPANT RESULTS)
      #  CLEANUP KILLED ARMIES 
      #  LET ARMIES RETREAT AND CLEANUP PARTICIPANT AND ARMY
      
      # CONTINUE BATTLE?
      # YES: CREATE EVENT FOR NEXT ROUND
      # NO: CLEANUP PARTICIPANTS, FACTIONS AND BATTLE; RESET ARMIES
      
      runloop.say awe_battle.inspect
      
      runloop.say "Battle round completed, cleaning up and destroying event."      


#     event.destroy
      runloop.say "Battle handler completed."
    end
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
    end       
  
    battle
  end

  def extract_results_from_awe_faction(awe_faction, faction, faction_results)
    (0..(awe_faction.numArmies-1)).each do | a |
      awe_army = awe_faction.getArmy(a)
      participant = faction.participants[a]
      participant_results = faction_results.participant_results.build(
        :battle_id => faction.battle_id,
        :round_id => faction_results.round.id,
  #      :faction_id => faction.id,             # TODO: add to database
        :army_id => participant.army.id,
  #      :kills => awe_army.numKills,
  #      :experience_gained => awe_army.experienceGained,
      )
      extract_results_from_awe_participant(awe_army, participant, participant_results)

      if !participant_results.save
        raise InternalServerError.new('Server could not create a new result for a battle participant in persistant storage.')
      end
      
    end
    
    faction_results
  end
  
  def extract_results_from_awe_participant(awe_army, participant, participant_results)
    rules = GameRules::Rules.the_rules
    
    (0..(awe_army.numUnits-1)).each do | u |
      awe_unit = awe_army.getUnit(u)
      unit_type = rules.unit_types[awe_unit.unitTypeId]
      
      participant_results[unit_type[:db_field]] = awe_unit.numUnitsAtStart
      participant_results[unit_type[:db_field]+'_casualties'] = awe_unit.numDeaths
  #    participant_results[unit_type[:db_field]+'_damage_taken'] = awe_unit.damageTaken
  #    participant_results[unit_type[:db_field]+'_damage_inflicted'] = awe_unit.damageInflicted

      # update survivors on army
    end
  end
  
  
  ## FILLING THE BATTLE STRUCTS ##############################################
  
  def create_awe_test_for(category)
    awe_priority_test = nil
    
    puts 'CREATE TEST'

    if category[:target_priorities][:test_type] == :no_test          # NO TEST
      
      puts 'CREATE NO TEST'
      
      awe_priority_test = Battle::NoTest.new
      category[:target_priorities][:results][0].each do | target |
        awe_priority_test.pushCategoryToPriority(target)
      end
      
    elsif category[:target_priorities][:test_type] == :line_size_test # LINE SIZE TEST
      
      puts 'CREATE LINE SIZE TEST'
      
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
    
    puts "finished categories"

    # fill factions
    battle.factions.each do |faction|
      awe_faction = Battle::Faction.new
      raise InternalServerError.new('could not create an instance of Battle::Faction (awe_native_extension).') if awe_faction.nil?
      
      fill_awe_faction(faction, awe_faction)
      awe_battle.addFaction(awe_faction)
    end
    
    puts "finished factions"
    
    awe_battle
  end
  
  def fill_awe_faction(faction, awe_faction)
    faction.participants.each do |participant|
      awe_army = Battle::Army.new(participant.army.owner_id)  # why player id?
      raise InternalServerError.new('could not create an instance of Battle::Army (awe_native_extension).') if awe_army.nil?
      
      fill_awe_army(participant, awe_army)
      awe_faction.addArmy(awe_army)
    end
    
    awe_faction
  end
  
  
  def fill_awe_army(participant, awe_army)
    rules = GameRules::Rules.the_rules
    
    rules.unit_types.each do | unit_type |
      if !participant.army.details[unit_type[:db_field]].nil? && participant.army.details[unit_type[:db_field]] > 0
        awe_unit = Battle::Unit.new
        raise InternalServerError.new('could not create an instance of Battle::Unit (awe_native_extension).') if awe_unit.nil?
        
        fill_awe_unit(participant.army.details[unit_type[:db_field]], unit_type, awe_unit)
        awe_army.addUnit(awe_unit)

      end
    end
    
    awe_army
  end
  
  # expects the number of "soldiers" in the army, the unit_type (from the 
  # rules) and the awe object to be filled.
  #
  # TODO: here we need the owner as the army as well and must calculate all modified values (perhaps should be calculated inside Military::Army)
  def fill_awe_unit(number, unit_type, awe_unit)
    awe_unit.numUnitsAtStart = number
    awe_unit.unitTypeId = unit_type[:id]
    awe_unit.unitCategoryId = 0 #  unit_type.id # must become a number!
    awe_unit.baseDamage = unit_type[:attack]
    awe_unit.criticalDamage = unit_type[:critical_hit_damage]
    awe_unit.criticalProbability = unit_type[:critical_hit_chance]
    awe_unit.hitpoints = unit_type[:hitpoints]
    awe_unit.initiative = unit_type[:initiative]
    awe_unit.armor = unit_type[:armor]
        
    awe_unit
  end
  
  
end






