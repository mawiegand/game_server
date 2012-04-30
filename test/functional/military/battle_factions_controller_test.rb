require 'test_helper'

class Military::BattleFactionsControllerTest < ActionController::TestCase
  setup do
    @military_battle_faction = military_battle_factions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:military_battle_factions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create military_battle_faction" do
    assert_difference('Military::BattleFaction.count') do
      post :create, military_battle_faction: @military_battle_faction.attributes
    end

    assert_redirected_to military_battle_faction_path(assigns(:military_battle_faction))
  end

  test "should show military_battle_faction" do
    get :show, id: @military_battle_faction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @military_battle_faction.to_param
    assert_response :success
  end

  test "should update military_battle_faction" do
    put :update, id: @military_battle_faction.to_param, military_battle_faction: @military_battle_faction.attributes
    assert_redirected_to military_battle_faction_path(assigns(:military_battle_faction))
  end

  test "should destroy military_battle_faction" do
    assert_difference('Military::BattleFaction.count', -1) do
      delete :destroy, id: @military_battle_faction.to_param
    end

    assert_redirected_to military_battle_factions_path
  end
end
