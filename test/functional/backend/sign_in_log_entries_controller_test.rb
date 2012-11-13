require 'test_helper'

class Backend::SignInLogEntriesControllerTest < ActionController::TestCase
  setup do
    @backend_sign_in_log_entry = backend_sign_in_log_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backend_sign_in_log_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backend_sign_in_log_entry" do
    assert_difference('Backend::SignInLogEntry.count') do
      post :create, backend_sign_in_log_entry: @backend_sign_in_log_entry.attributes
    end

    assert_redirected_to backend_sign_in_log_entry_path(assigns(:backend_sign_in_log_entry))
  end

  test "should show backend_sign_in_log_entry" do
    get :show, id: @backend_sign_in_log_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend_sign_in_log_entry.to_param
    assert_response :success
  end

  test "should update backend_sign_in_log_entry" do
    put :update, id: @backend_sign_in_log_entry.to_param, backend_sign_in_log_entry: @backend_sign_in_log_entry.attributes
    assert_redirected_to backend_sign_in_log_entry_path(assigns(:backend_sign_in_log_entry))
  end

  test "should destroy backend_sign_in_log_entry" do
    assert_difference('Backend::SignInLogEntry.count', -1) do
      delete :destroy, id: @backend_sign_in_log_entry.to_param
    end

    assert_redirected_to backend_sign_in_log_entries_path
  end
end
