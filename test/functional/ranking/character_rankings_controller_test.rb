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
end
