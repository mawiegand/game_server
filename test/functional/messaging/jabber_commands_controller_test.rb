require 'test_helper'

class Messaging::JabberCommandsControllerTest < ActionController::TestCase
  setup do
    @messaging_jabber_command = messaging_jabber_commands(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messaging_jabber_commands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create messaging_jabber_command" do
    assert_difference('Messaging::JabberCommand.count') do
      post :create, messaging_jabber_command: @messaging_jabber_command.attributes
    end

    assert_redirected_to messaging_jabber_command_path(assigns(:messaging_jabber_command))
  end

  test "should show messaging_jabber_command" do
    get :show, id: @messaging_jabber_command.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messaging_jabber_command.to_param
    assert_response :success
  end

  test "should update messaging_jabber_command" do
    put :update, id: @messaging_jabber_command.to_param, messaging_jabber_command: @messaging_jabber_command.attributes
    assert_redirected_to messaging_jabber_command_path(assigns(:messaging_jabber_command))
  end

  test "should destroy messaging_jabber_command" do
    assert_difference('Messaging::JabberCommand.count', -1) do
      delete :destroy, id: @messaging_jabber_command.to_param
    end

    assert_redirected_to messaging_jabber_commands_path
  end
end
