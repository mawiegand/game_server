require 'test_helper'

class Military::BattleCharacterResultsControllerTest < ActionController::TestCase
  setup do
    @military_battle_character_result = military_battle_character_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:military_battle_character_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create military_battle_character_result" do
    assert_difference('Military::BattleCharacterResult.count') do
      post :create, military_battle_character_result: @military_battle_character_result.attributes
    end

    assert_redirected_to military_battle_character_result_path(assigns(:military_battle_character_result))
  end

  test "should show military_battle_character_result" do
    get :show, id: @military_battle_character_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @military_battle_character_result.to_param
    assert_response :success
  end

  test "should update military_battle_character_result" do
    put :update, id: @military_battle_character_result.to_param, military_battle_character_result: @military_battle_character_result.attributes
    assert_redirected_to military_battle_character_result_path(assigns(:military_battle_character_result))
  end

  test "should destroy military_battle_character_result" do
    assert_difference('Military::BattleCharacterResult.count', -1) do
      delete :destroy, id: @military_battle_character_result.to_param
    end

    assert_redirected_to military_battle_character_results_path
  end
end
