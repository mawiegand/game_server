require 'test_helper'

class Fundamental::AllianceLeaderVotesControllerTest < ActionController::TestCase
  setup do
    @fundamental_alliance_leader_vote = fundamental_alliance_leader_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_alliance_leader_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_alliance_leader_vote" do
    assert_difference('Fundamental::AllianceLeaderVote.count') do
      post :create, fundamental_alliance_leader_vote: @fundamental_alliance_leader_vote.attributes
    end

    assert_redirected_to fundamental_alliance_leader_vote_path(assigns(:fundamental_alliance_leader_vote))
  end

  test "should show fundamental_alliance_leader_vote" do
    get :show, id: @fundamental_alliance_leader_vote.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_alliance_leader_vote.to_param
    assert_response :success
  end

  test "should update fundamental_alliance_leader_vote" do
    put :update, id: @fundamental_alliance_leader_vote.to_param, fundamental_alliance_leader_vote: @fundamental_alliance_leader_vote.attributes
    assert_redirected_to fundamental_alliance_leader_vote_path(assigns(:fundamental_alliance_leader_vote))
  end

  test "should destroy fundamental_alliance_leader_vote" do
    assert_difference('Fundamental::AllianceLeaderVote.count', -1) do
      delete :destroy, id: @fundamental_alliance_leader_vote.to_param
    end

    assert_redirected_to fundamental_alliance_leader_votes_path
  end
end
