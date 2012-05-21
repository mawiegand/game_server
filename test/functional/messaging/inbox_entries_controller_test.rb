require 'test_helper'

class Messaging::InboxEntriesControllerTest < ActionController::TestCase
  setup do
    @messaging_inbox_entry = messaging_inbox_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messaging_inbox_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create messaging_inbox_entry" do
    assert_difference('Messaging::InboxEntry.count') do
      post :create, messaging_inbox_entry: @messaging_inbox_entry.attributes
    end

    assert_redirected_to messaging_inbox_entry_path(assigns(:messaging_inbox_entry))
  end

  test "should show messaging_inbox_entry" do
    get :show, id: @messaging_inbox_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messaging_inbox_entry.to_param
    assert_response :success
  end

  test "should update messaging_inbox_entry" do
    put :update, id: @messaging_inbox_entry.to_param, messaging_inbox_entry: @messaging_inbox_entry.attributes
    assert_redirected_to messaging_inbox_entry_path(assigns(:messaging_inbox_entry))
  end

  test "should destroy messaging_inbox_entry" do
    assert_difference('Messaging::InboxEntry.count', -1) do
      delete :destroy, id: @messaging_inbox_entry.to_param
    end

    assert_redirected_to messaging_inbox_entries_path
  end
end
