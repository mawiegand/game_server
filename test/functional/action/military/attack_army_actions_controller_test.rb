require 'test_helper'

class Action::Military::AttackArmyActionsControllerTest < ActionController::TestCase
  setup do
    @action_military_attack_army_action = action_military_attack_army_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:action_military_attack_army_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create action_military_attack_army_action" do
    assert_difference('Action::Military::AttackArmyAction.count') do
      post :create, action_military_attack_army_action: @action_military_attack_army_action.attributes
    end

    assert_redirected_to action_military_attack_army_action_path(assigns(:action_military_attack_army_action))
  end

  test "should show action_military_attack_army_action" do
    get :show, id: @action_military_attack_army_action.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @action_military_attack_army_action.to_param
    assert_response :success
  end

  test "should update action_military_attack_army_action" do
    put :update, id: @action_military_attack_army_action.to_param, action_military_attack_army_action: @action_military_attack_army_action.attributes
    assert_redirected_to action_military_attack_army_action_path(assigns(:action_military_attack_army_action))
  end

  test "should destroy action_military_attack_army_action" do
    assert_difference('Action::Military::AttackArmyAction.count', -1) do
      delete :destroy, id: @action_military_attack_army_action.to_param
    end

    assert_redirected_to action_military_attack_army_actions_path
  end
end
