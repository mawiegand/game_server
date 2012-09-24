require 'test_helper'

class Military::BattleRoundsControllerTest < ActionController::TestCase
  setup do
    @military_battle_round = military_battle_rounds(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:military_battle_rounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create military_battle_round" do
    assert_difference('Military::BattleRound.count') do
      post :create, military_battle_round: @military_battle_round.attributes
    end

    assert_redirected_to military_battle_round_path(assigns(:military_battle_round))
  end

  test "should show military_battle_round" do
    get :show, id: @military_battle_round.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @military_battle_round.to_param
    assert_response :success
  end

  test "should update military_battle_round" do
    put :update, id: @military_battle_round.to_param, military_battle_round: @military_battle_round.attributes
    assert_redirected_to military_battle_round_path(assigns(:military_battle_round))
  end

  test "should destroy military_battle_round" do
    assert_difference('Military::BattleRound.count', -1) do
      delete :destroy, id: @military_battle_round.to_param
    end

    assert_redirected_to military_battle_rounds_path
  end
end
