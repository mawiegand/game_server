require 'test_helper'

class Map::SubtreesControllerTest < ActionController::TestCase
  setup do
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end  
  
#  test "should show subtree" do
#    get :show, :id => "1"
#    assert_response :success
#  end

end
