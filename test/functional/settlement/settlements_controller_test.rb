require 'test_helper'

class Settlement::SettlementsControllerTest < ActionController::TestCase
  setup do
    @settlement_settlement = settlement_settlements(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:settlement_settlements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create settlement_settlement" do
    assert_difference('Settlement::Settlement.count') do
      post :create, settlement_settlement: @settlement_settlement.attributes
    end

    assert_redirected_to settlement_settlement_path(assigns(:settlement_settlement))
  end

  test "should show settlement_settlement" do
    get :show, id: @settlement_settlement.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @settlement_settlement.to_param
    assert_response :success
  end

  test "should update settlement_settlement" do
    put :update, id: @settlement_settlement.to_param, settlement_settlement: @settlement_settlement.attributes
    assert_redirected_to settlement_settlement_path(assigns(:settlement_settlement))
  end

  test "should destroy settlement_settlement" do
    assert_difference('Settlement::Settlement.count', -1) do
      delete :destroy, id: @settlement_settlement.to_param
    end

    assert_redirected_to settlement_settlements_path
  end
end
