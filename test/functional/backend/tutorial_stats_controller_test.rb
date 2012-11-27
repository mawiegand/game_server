require 'test_helper'

class Backend::TutorialStatsControllerTest < ActionController::TestCase
  setup do
    @backend_tutorial_stat = backend_tutorial_stats(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backend_tutorial_stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backend_tutorial_stat" do
    assert_difference('Backend::TutorialStat.count') do
      post :create, backend_tutorial_stat: @backend_tutorial_stat.attributes
    end

    assert_redirected_to backend_tutorial_stat_path(assigns(:backend_tutorial_stat))
  end

  test "should show backend_tutorial_stat" do
    get :show, id: @backend_tutorial_stat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend_tutorial_stat.to_param
    assert_response :success
  end

  test "should update backend_tutorial_stat" do
    put :update, id: @backend_tutorial_stat.to_param, backend_tutorial_stat: @backend_tutorial_stat.attributes
    assert_redirected_to backend_tutorial_stat_path(assigns(:backend_tutorial_stat))
  end

  test "should destroy backend_tutorial_stat" do
    assert_difference('Backend::TutorialStat.count', -1) do
      delete :destroy, id: @backend_tutorial_stat.to_param
    end

    assert_redirected_to backend_tutorial_stats_path
  end
end
