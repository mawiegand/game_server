require 'test_helper'

class Backend::TradeLogEntriesControllerTest < ActionController::TestCase
  setup do
    @backend_trade_log_entry = backend_trade_log_entries(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backend_trade_log_entries)
  end
end
