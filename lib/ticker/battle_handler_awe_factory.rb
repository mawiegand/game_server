require 'ticker/runloop'
require 'awe_native_extensions'

class Ticker::BattleHandler

  def runloop 
    return @runloop 
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
      if (c[:symbolic_id].to_s == category_symbol.to_s)
        return c[:id]
      end
    } 
    raise InternalServerError.new('could not find the associated unit_category for a symbol.')
  end
end