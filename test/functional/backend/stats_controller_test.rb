require 'test_helper'

class Backend::StatsControllerTest < ActionController::TestCase
  setup do
    @backend_stat = backend_stats(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backend_stats)
  end


  test "should create backend_stat" do
    assert_difference('Backend::Stat.count') do
      post :create, backend_stat: @backend_stat.attributes
    end

    assert_redirected_to backend_stats_path
  end

  test "should show backend_stat" do
    get :show, id: @backend_stat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend_stat.to_param
    assert_response :success
  end

  test "should update backend_stat" do
    put :update, id: @backend_stat.to_param, backend_stat: @backend_stat.attributes
    assert_redirected_to backend_stat_path(assigns(:backend_stat))
  end

  test "should destroy backend_stat" do
    assert_difference('Backend::Stat.count', -1) do
      delete :destroy, id: @backend_stat.to_param
    end

    assert_redirected_to backend_stats_path
  end
end
