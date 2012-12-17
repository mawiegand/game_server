require 'test_helper'

class Fundamental::VictoryProgressesControllerTest < ActionController::TestCase
  setup do
    @fundamental_victory_progress = fundamental_victory_progresses(:one)
    @controller.current_backend_user = backend_users(:admin)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_victory_progresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_victory_progress" do
    assert_difference('Fundamental::VictoryProgress.count') do
      post :create, fundamental_victory_progress: @fundamental_victory_progress.attributes
    end

    assert_redirected_to fundamental_victory_progress_path(assigns(:fundamental_victory_progress))
  end

  test "should show fundamental_victory_progress" do
    get :show, id: @fundamental_victory_progress.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_victory_progress.to_param
    assert_response :success
  end

  test "should update fundamental_victory_progress" do
    put :update, id: @fundamental_victory_progress.to_param, fundamental_victory_progress: @fundamental_victory_progress.attributes
    assert_redirected_to fundamental_victory_progress_path(assigns(:fundamental_victory_progress))
  end

  test "should destroy fundamental_victory_progress" do
    assert_difference('Fundamental::VictoryProgress.count', -1) do
      delete :destroy, id: @fundamental_victory_progress.to_param
    end

    assert_redirected_to fundamental_victory_progresses_path
  end
end
