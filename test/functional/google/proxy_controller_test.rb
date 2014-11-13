require 'test_helper'

class Google::ProxyControllerTest < ActionController::TestCase
  test "should get verify_order" do
    get :verify_order
    assert_response :success
  end

end
