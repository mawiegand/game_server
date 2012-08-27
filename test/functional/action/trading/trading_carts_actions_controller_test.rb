require 'test_helper'

class Action::Trading::TradingCartsActionsControllerTest < ActionController::TestCase
  setup do
    @action_trading_trading_carts_action = action_trading_trading_carts_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:action_trading_trading_carts_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create action_trading_trading_carts_action" do
    assert_difference('Action::Trading::TradingCartsAction.count') do
      post :create, action_trading_trading_carts_action: @action_trading_trading_carts_action.attributes
    end

    assert_redirected_to action_trading_trading_carts_action_path(assigns(:action_trading_trading_carts_action))
  end

  test "should show action_trading_trading_carts_action" do
    get :show, id: @action_trading_trading_carts_action.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @action_trading_trading_carts_action.to_param
    assert_response :success
  end

  test "should update action_trading_trading_carts_action" do
    put :update, id: @action_trading_trading_carts_action.to_param, action_trading_trading_carts_action: @action_trading_trading_carts_action.attributes
    assert_redirected_to action_trading_trading_carts_action_path(assigns(:action_trading_trading_carts_action))
  end

  test "should destroy action_trading_trading_carts_action" do
    assert_difference('Action::Trading::TradingCartsAction.count', -1) do
      delete :destroy, id: @action_trading_trading_carts_action.to_param
    end

    assert_redirected_to action_trading_trading_carts_actions_path
  end
end
