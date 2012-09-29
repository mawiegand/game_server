require 'test_helper'

class Military::ArmyTest < ActiveSupport::TestCase

  test "experience update can handle nil" do
    army = Military::Army.find(1)
    army.exp = nil
    assert army.save
    assert_not_nil army.owner
    
    army.exp = 1
    army.send :update_experience_character
    assert_equal 1, army.exp
  end
  
  
  # ##########################################################################
  #
  #   SETTLEMENT FOUNDING
  #
  # ########################################################################## 
  

  test "army knows, when its able to found outposts" do
    army = military_armies(:one)
    
    assert_not_nil army.details
    assert !army.can_found_outpost?
    
    founder_field = nil
    
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      founder_field = unit_type[:db_field]  if !unit_type[:can_create].nil?
    end    
    army.details[founder_field] = 1
    
    assert army.can_found_outpost?
    
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      army.details[unit_type[:db_field]] = 1  if !unit_type[:can_create].nil?
    end    
    
    assert army.can_found_outpost?
  end
  
  test "settlement founder is properly consumed" do
    army = military_armies(:one)
    
    assert_not_nil army.details
    
    founder_field = nil
    
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      founder_field = unit_type[:db_field]  if !unit_type[:can_create].nil? && founder_field.nil?
    end    
    army.details[founder_field] = 5
    
    assert_difference(lambda {army.details[founder_field]}, -1) do
      army.consume_one_settlement_founder!
    end
  end
  
  test "army can found outpost" do
    character = fundamental_characters(:owner)
    location  = map_locations(:two)
    region    = map_regions(:one)
    node      = map_nodes(:one)
    army      = military_armies(:one)

    region.node     = node
    location.region = region
    location.slot   = 1      # nil || zero is assumed a fortress, thus use a larger number
    army.location   = location
    army.owner      = character
    
    character.update_settlement_points_used
    character.settlement_points_total = (character.settlement_points_used || 0) + 1
    
    founder_field = nil
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      founder_field = unit_type[:db_field]  if !unit_type[:can_create].nil? && founder_field.nil?
    end    
    army.details[founder_field] = 1
    
    assert_difference(lambda {army.details[founder_field]}, -1) do
      settlement = army.found_outpost!
      assert_not_nil settlement
      assert_not_nil settlement.garrison_army.nil?
    end
  end
end



