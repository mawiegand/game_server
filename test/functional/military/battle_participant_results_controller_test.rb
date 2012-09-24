require 'test_helper'

class Military::BattleParticipantResultsControllerTest < ActionController::TestCase
  setup do
    @military_battle_participant_result = military_battle_participant_results(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:military_battle_participant_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create military_battle_participant_result" do
    assert_difference('Military::BattleParticipantResult.count') do
      post :create, military_battle_participant_result: @military_battle_participant_result.attributes
    end

    assert_redirected_to military_battle_participant_result_path(assigns(:military_battle_participant_result))
  end

  test "should show military_battle_participant_result" do
    get :show, id: @military_battle_participant_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @military_battle_participant_result.to_param
    assert_response :success
  end

  test "should update military_battle_participant_result" do
    put :update, id: @military_battle_participant_result.to_param, military_battle_participant_result: @military_battle_participant_result.attributes
    assert_redirected_to military_battle_participant_result_path(assigns(:military_battle_participant_result))
  end

  test "should destroy military_battle_participant_result" do
    assert_difference('Military::BattleParticipantResult.count', -1) do
      delete :destroy, id: @military_battle_participant_result.to_param
    end

    assert_redirected_to military_battle_participant_results_path
  end
end
