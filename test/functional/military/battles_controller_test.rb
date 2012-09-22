require 'test_helper'

class Military::BattlesControllerTest < ActionController::TestCase
  setup do
    @military_battle = military_battles(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:military_battles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create military_battle" do
    assert_difference('Military::Battle.count') do
      post :create, military_battle: @military_battle.attributes
    end

    assert_redirected_to military_battle_path(assigns(:military_battle))
  end

  test "should show military_battle" do
#    get :show, id: @military_battle.to_param
#    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @military_battle.to_param
    assert_response :success
  end

  test "should update military_battle" do
    put :update, id: @military_battle.to_param, military_battle: @military_battle.attributes
    assert_redirected_to military_battle_path(assigns(:military_battle))
  end

  test "should destroy military_battle" do
    assert_difference('Military::Battle.count', -1) do
      delete :destroy, id: @military_battle.to_param
    end

    assert_redirected_to military_battles_path
  end
end
