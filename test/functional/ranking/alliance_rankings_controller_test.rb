require 'test_helper'

class Ranking::AllianceRankingsControllerTest < ActionController::TestCase
  setup do
    @ranking_alliance_ranking = ranking_alliance_rankings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ranking_alliance_rankings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ranking_alliance_ranking" do
    assert_difference('Ranking::AllianceRanking.count') do
      post :create, ranking_alliance_ranking: @ranking_alliance_ranking.attributes
    end

    assert_redirected_to ranking_alliance_ranking_path(assigns(:ranking_alliance_ranking))
  end

  test "should show ranking_alliance_ranking" do
    get :show, id: @ranking_alliance_ranking.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ranking_alliance_ranking.to_param
    assert_response :success
  end

  test "should update ranking_alliance_ranking" do
    put :update, id: @ranking_alliance_ranking.to_param, ranking_alliance_ranking: @ranking_alliance_ranking.attributes
    assert_redirected_to ranking_alliance_ranking_path(assigns(:ranking_alliance_ranking))
  end

  test "should destroy ranking_alliance_ranking" do
    assert_difference('Ranking::AllianceRanking.count', -1) do
      delete :destroy, id: @ranking_alliance_ranking.to_param
    end

    assert_redirected_to ranking_alliance_rankings_path
  end
end
