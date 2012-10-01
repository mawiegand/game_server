require 'test_helper'

class Action::Military::FoundOutpostActionsControllerTest < ActionController::TestCase


  test "should create action_military_found_outpost_action" do
    
    character = Fundamental::Character.find(1)
    army      = character.armies.first

    army.location = Map::Location.find(2)
    
    character.update_settlement_points_used
    character.settlement_points_total = (character.settlement_points_used || 0) + 1
    
    founder_field = nil
    GameRules::Rules.the_rules.unit_types.each do |unit_type|
      founder_field = unit_type[:db_field]  if !unit_type[:can_create].nil? && founder_field.nil?
    end
    assert_not_nil founder_field    
    army.details[founder_field] = 2 ## army will NOT be deleted
    
    puts army.inspect
    puts army.details.inspect
    
    assert army.save
    assert_not_nil army.details
    assert !army.frozen?
    
    assert army.details.save
    assert character.save
    
    @controller.current_character = army.owner
    
    post :create, found_outpost_action: {
      army_id: army.id,
      location_id: army.location.id,
    }, format: "json"

    assert_response :ok
    
  end

end