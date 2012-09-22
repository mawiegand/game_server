require 'test_helper'

class Action::Military::AttackArmyActionsControllerTest < ActionController::TestCase
  setup do
    @action_military_attack_army_action = action_military_attack_army_actions(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

#  test "should create action_military_attack_army_action" do
#    assert_difference('Action::Military::AttackArmyAction.count') do
#      post :create, action_military_attack_army_action: @action_military_attack_army_action.attributes
#    end

#    assert_redirected_to action_military_attack_army_action_path(assigns(:action_military_attack_army_action))
#  end


end
