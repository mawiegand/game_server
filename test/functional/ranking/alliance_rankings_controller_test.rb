require 'test_helper'

class Ranking::AllianceRankingsControllerTest < ActionController::TestCase
  setup do
    @ranking_alliance_ranking = ranking_alliance_rankings(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ranking_alliance_rankings)
  end
end
