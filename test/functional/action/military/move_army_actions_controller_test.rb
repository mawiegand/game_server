require 'test_helper'

class Action::Military::MoveArmyActionsControllerTest < ActionController::TestCase
  setup do
    @action_military_move_army_action = action_military_move_army_actions(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:action_military_move_army_actions)
  end

#  test "should create action_military_move_army_action" do
#    assert_difference('Action::Military::MoveArmyAction.count') do
#      post :create, action_military_move_army_action: @action_military_move_army_action.attributes
#    end

#    assert_redirected_to action_military_move_army_action_path(assigns(:action_military_move_army_action))
#  end

  test "should show action_military_move_army_action" do
    get :show, id: @action_military_move_army_action.to_param
    assert_response :success
  end
end
