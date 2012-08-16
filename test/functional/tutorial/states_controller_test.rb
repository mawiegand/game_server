require 'test_helper'

class Tutorial::StatesControllerTest < ActionController::TestCase
  setup do
    @tutorial_state = tutorial_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tutorial_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tutorial_state" do
    assert_difference('Tutorial::State.count') do
      post :create, tutorial_state: @tutorial_state.attributes
    end

    assert_redirected_to tutorial_state_path(assigns(:tutorial_state))
  end

  test "should show tutorial_state" do
    get :show, id: @tutorial_state.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tutorial_state.to_param
    assert_response :success
  end

  test "should update tutorial_state" do
    put :update, id: @tutorial_state.to_param, tutorial_state: @tutorial_state.attributes
    assert_redirected_to tutorial_state_path(assigns(:tutorial_state))
  end

  test "should destroy tutorial_state" do
    assert_difference('Tutorial::State.count', -1) do
      delete :destroy, id: @tutorial_state.to_param
    end

    assert_redirected_to tutorial_states_path
  end
end
