require 'test_helper'

class Military::BattleFactionResultsControllerTest < ActionController::TestCase
  setup do
    @military_battle_faction_result = military_battle_faction_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:military_battle_faction_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create military_battle_faction_result" do
    assert_difference('Military::BattleFactionResult.count') do
      post :create, military_battle_faction_result: @military_battle_faction_result.attributes
    end

    assert_redirected_to military_battle_faction_result_path(assigns(:military_battle_faction_result))
  end

  test "should show military_battle_faction_result" do
    get :show, id: @military_battle_faction_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @military_battle_faction_result.to_param
    assert_response :success
  end

  test "should update military_battle_faction_result" do
    put :update, id: @military_battle_faction_result.to_param, military_battle_faction_result: @military_battle_faction_result.attributes
    assert_redirected_to military_battle_faction_result_path(assigns(:military_battle_faction_result))
  end

  test "should destroy military_battle_faction_result" do
    assert_difference('Military::BattleFactionResult.count', -1) do
      delete :destroy, id: @military_battle_faction_result.to_param
    end

    assert_redirected_to military_battle_faction_results_path
  end
end
