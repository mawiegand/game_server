require 'test_helper'

class Messaging::OutboxEntriesControllerTest < ActionController::TestCase
  setup do
    @messaging_outbox_entry = messaging_outbox_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messaging_outbox_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create messaging_outbox_entry" do
    assert_difference('Messaging::OutboxEntry.count') do
      post :create, messaging_outbox_entry: @messaging_outbox_entry.attributes
    end

    assert_redirected_to messaging_outbox_entry_path(assigns(:messaging_outbox_entry))
  end

  test "should show messaging_outbox_entry" do
    get :show, id: @messaging_outbox_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messaging_outbox_entry.to_param
    assert_response :success
  end

  test "should update messaging_outbox_entry" do
    put :update, id: @messaging_outbox_entry.to_param, messaging_outbox_entry: @messaging_outbox_entry.attributes
    assert_redirected_to messaging_outbox_entry_path(assigns(:messaging_outbox_entry))
  end

  test "should destroy messaging_outbox_entry" do
    assert_difference('Messaging::OutboxEntry.count', -1) do
      delete :destroy, id: @messaging_outbox_entry.to_param
    end

    assert_redirected_to messaging_outbox_entries_path
  end
end
