require 'test_helper'

class Ranking::CharacterRankingsControllerTest < ActionController::TestCase
  setup do
    @ranking_character_ranking = ranking_character_rankings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ranking_character_rankings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ranking_character_ranking" do
    assert_difference('Ranking::CharacterRanking.count') do
      post :create, ranking_character_ranking: @ranking_character_ranking.attributes
    end

    assert_redirected_to ranking_character_ranking_path(assigns(:ranking_character_ranking))
  end

  test "should show ranking_character_ranking" do
    get :show, id: @ranking_character_ranking.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ranking_character_ranking.to_param
    assert_response :success
  end

  test "should update ranking_character_ranking" do
    put :update, id: @ranking_character_ranking.to_param, ranking_character_ranking: @ranking_character_ranking.attributes
    assert_redirected_to ranking_character_ranking_path(assigns(:ranking_character_ranking))
  end

  test "should destroy ranking_character_ranking" do
    assert_difference('Ranking::CharacterRanking.count', -1) do
      delete :destroy, id: @ranking_character_ranking.to_param
    end

    assert_redirected_to ranking_character_rankings_path
  end
end
