require 'test_helper'

class Action::Military::AttackArmyActionsControllerTest < ActionController::TestCase
  setup do
    @action_military_attack_army_action = action_military_attack_army_actions(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "shoud fail" do
    assert false
  end
    


end
