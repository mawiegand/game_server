require 'test_helper'

class Military::BattleParticipantsControllerTest < ActionController::TestCase
  setup do
    @military_battle_participant = military_battle_participants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:military_battle_participants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create military_battle_participant" do
    assert_difference('Military::BattleParticipant.count') do
      post :create, military_battle_participant: @military_battle_participant.attributes
    end

    assert_redirected_to military_battle_participant_path(assigns(:military_battle_participant))
  end

  test "should show military_battle_participant" do
    get :show, id: @military_battle_participant.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @military_battle_participant.to_param
    assert_response :success
  end

  test "should update military_battle_participant" do
    put :update, id: @military_battle_participant.to_param, military_battle_participant: @military_battle_participant.attributes
    assert_redirected_to military_battle_participant_path(assigns(:military_battle_participant))
  end

  test "should destroy military_battle_participant" do
    assert_difference('Military::BattleParticipant.count', -1) do
      delete :destroy, id: @military_battle_participant.to_param
    end

    assert_redirected_to military_battle_participants_path
  end
end
