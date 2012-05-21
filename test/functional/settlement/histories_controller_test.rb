require 'test_helper'

class Settlement::HistoriesControllerTest < ActionController::TestCase
  setup do
    @settlement_history = settlement_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:settlement_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create settlement_history" do
    assert_difference('Settlement::History.count') do
      post :create, settlement_history: @settlement_history.attributes
    end

    assert_redirected_to settlement_history_path(assigns(:settlement_history))
  end

  test "should show settlement_history" do
    get :show, id: @settlement_history.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @settlement_history.to_param
    assert_response :success
  end

  test "should update settlement_history" do
    put :update, id: @settlement_history.to_param, settlement_history: @settlement_history.attributes
    assert_redirected_to settlement_history_path(assigns(:settlement_history))
  end

  test "should destroy settlement_history" do
    assert_difference('Settlement::History.count', -1) do
      delete :destroy, id: @settlement_history.to_param
    end

    assert_redirected_to settlement_histories_path
  end
end
