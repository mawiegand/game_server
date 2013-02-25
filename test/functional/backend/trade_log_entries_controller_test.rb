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

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backend_trade_log_entry" do
    assert_difference('Backend::TradeLogEntry.count') do
      post :create, backend_trade_log_entry: @backend_trade_log_entry.attributes
    end

    assert_redirected_to backend_trade_log_entry_path(assigns(:backend_trade_log_entry))
  end

  test "should show backend_trade_log_entry" do
    get :show, id: @backend_trade_log_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend_trade_log_entry.to_param
    assert_response :success
  end

  test "should update backend_trade_log_entry" do
    put :update, id: @backend_trade_log_entry.to_param, backend_trade_log_entry: @backend_trade_log_entry.attributes
    assert_redirected_to backend_trade_log_entry_path(assigns(:backend_trade_log_entry))
  end

  test "should destroy backend_trade_log_entry" do
    assert_difference('Backend::TradeLogEntry.count', -1) do
      delete :destroy, id: @backend_trade_log_entry.to_param
    end

    assert_redirected_to backend_trade_log_entries_path
  end
end
