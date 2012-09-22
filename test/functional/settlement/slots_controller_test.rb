require 'test_helper'

class Settlement::SlotsControllerTest < ActionController::TestCase
  setup do
    @settlement_slot = settlement_slots(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:settlement_slots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create settlement_slot" do
    assert_difference('Settlement::Slot.count') do
      post :create, settlement_slot: @settlement_slot.attributes
    end

    assert_redirected_to settlement_slot_path(assigns(:settlement_slot))
  end

  test "should show settlement_slot" do
    get :show, id: @settlement_slot.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @settlement_slot.to_param
    assert_response :success
  end

  test "should update settlement_slot" do
    put :update, id: @settlement_slot.to_param, settlement_slot: @settlement_slot.attributes
    assert_redirected_to settlement_slot_path(assigns(:settlement_slot))
  end

  test "should destroy settlement_slot" do
    assert_difference('Settlement::Slot.count', -1) do
      delete :destroy, id: @settlement_slot.to_param
    end

    assert_redirected_to settlement_slots_path
  end
end
