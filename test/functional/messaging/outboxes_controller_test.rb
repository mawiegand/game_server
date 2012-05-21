require 'test_helper'

class Messaging::OutboxesControllerTest < ActionController::TestCase
  setup do
    @messaging_outbox = messaging_outboxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messaging_outboxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create messaging_outbox" do
    assert_difference('Messaging::Outbox.count') do
      post :create, messaging_outbox: @messaging_outbox.attributes
    end

    assert_redirected_to messaging_outbox_path(assigns(:messaging_outbox))
  end

  test "should show messaging_outbox" do
    get :show, id: @messaging_outbox.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messaging_outbox.to_param
    assert_response :success
  end

  test "should update messaging_outbox" do
    put :update, id: @messaging_outbox.to_param, messaging_outbox: @messaging_outbox.attributes
    assert_redirected_to messaging_outbox_path(assigns(:messaging_outbox))
  end

  test "should destroy messaging_outbox" do
    assert_difference('Messaging::Outbox.count', -1) do
      delete :destroy, id: @messaging_outbox.to_param
    end

    assert_redirected_to messaging_outboxes_path
  end
end
