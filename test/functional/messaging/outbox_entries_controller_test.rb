require 'test_helper'

class Messaging::OutboxEntriesControllerTest < ActionController::TestCase
  setup do
    @messaging_outbox_entry = messaging_outbox_entries(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messaging_outbox_entries)
  end



  test "should show messaging_outbox_entry" do
    get :show, id: @messaging_outbox_entry.to_param
    assert_response :success
  end


  test "should update messaging_outbox_entry" do
    put :update, id: @messaging_outbox_entry.to_param, messaging_outbox_entry: @messaging_outbox_entry.attributes
    assert_redirected_to messaging_outbox_entry_path(assigns(:messaging_outbox_entry))
  end


end
