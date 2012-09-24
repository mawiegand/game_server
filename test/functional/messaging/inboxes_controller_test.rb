require 'test_helper'

class Messaging::InboxesControllerTest < ActionController::TestCase
  setup do
    @messaging_inbox = messaging_inboxes(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messaging_inboxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create messaging_inbox" do
    assert_difference('Messaging::Inbox.count') do
      post :create, messaging_inbox: @messaging_inbox.attributes
    end

    assert_redirected_to messaging_inbox_path(assigns(:messaging_inbox))
  end

  test "should show messaging_inbox" do
    get :show, id: @messaging_inbox.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messaging_inbox.to_param
    assert_response :success
  end

  test "should update messaging_inbox" do
    put :update, id: @messaging_inbox.to_param, messaging_inbox: @messaging_inbox.attributes
    assert_redirected_to messaging_inbox_path(assigns(:messaging_inbox))
  end

  test "should destroy messaging_inbox" do
    assert_difference('Messaging::Inbox.count', -1) do
      delete :destroy, id: @messaging_inbox.to_param
    end

    assert_redirected_to messaging_inboxes_path
  end
end
