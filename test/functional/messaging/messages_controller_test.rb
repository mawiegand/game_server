require 'test_helper'

class Messaging::MessagesControllerTest < ActionController::TestCase
  setup do
    @messaging_message = messaging_messages(:one)
    @controller.current_backend_user = backend_users(:admin)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messaging_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

#  test "should create messaging_message" do
#    assert_difference('Messaging::Message.count') do
#      post :create, messaging_message: @messaging_message.attributes
#    end

#    assert_redirected_to messaging_message_path(assigns(:messaging_message))
#  end

  test "should show messaging_message" do
    get :show, id: @messaging_message.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messaging_message.to_param
    assert_response :success
  end

  test "should update messaging_message" do
    put :update, id: @messaging_message.to_param, messaging_message: @messaging_message.attributes
    assert_redirected_to messaging_message_path(assigns(:messaging_message))
  end

  test "should destroy messaging_message" do
    assert_difference('Messaging::Message.count', -1) do
      delete :destroy, id: @messaging_message.to_param
    end

    assert_redirected_to messaging_messages_path
  end
end
