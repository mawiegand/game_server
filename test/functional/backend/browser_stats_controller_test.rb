require 'test_helper'

class Backend::BrowserStatsControllerTest < ActionController::TestCase
  setup do
    @backend_browser_stat = backend_browser_stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backend_browser_stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backend_browser_stat" do
    assert_difference('Backend::BrowserStat.count') do
      post :create, backend_browser_stat: @backend_browser_stat.attributes
    end

    assert_redirected_to backend_browser_stat_path(assigns(:backend_browser_stat))
  end

  test "should show backend_browser_stat" do
    get :show, id: @backend_browser_stat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend_browser_stat.to_param
    assert_response :success
  end

  test "should update backend_browser_stat" do
    put :update, id: @backend_browser_stat.to_param, backend_browser_stat: @backend_browser_stat.attributes
    assert_redirected_to backend_browser_stat_path(assigns(:backend_browser_stat))
  end

  test "should destroy backend_browser_stat" do
    assert_difference('Backend::BrowserStat.count', -1) do
      delete :destroy, id: @backend_browser_stat.to_param
    end

    assert_redirected_to backend_browser_stats_path
  end
end
