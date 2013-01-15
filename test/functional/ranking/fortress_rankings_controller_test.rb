require 'test_helper'

class Ranking::FortressRankingsControllerTest < ActionController::TestCase
  setup do
    @ranking_fortress_ranking = settlement_settlements(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
