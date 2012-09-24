require 'test_helper'

class Fundamental::ResourcePoolsControllerTest < ActionController::TestCase
  setup do
    @fundamental_resource_pool = fundamental_resource_pools(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_resource_pools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_resource_pool" do
    assert_difference('Fundamental::ResourcePool.count') do
      post :create, fundamental_resource_pool: @fundamental_resource_pool.attributes
    end

    assert_redirected_to fundamental_resource_pool_path(assigns(:fundamental_resource_pool))
  end

  test "should show fundamental_resource_pool" do
    get :show, id: @fundamental_resource_pool.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_resource_pool.to_param
    assert_response :success
  end

  test "should update fundamental_resource_pool" do
    put :update, id: @fundamental_resource_pool.to_param, fundamental_resource_pool: @fundamental_resource_pool.attributes
    assert_redirected_to fundamental_resource_pool_path(assigns(:fundamental_resource_pool))
  end

  test "should destroy fundamental_resource_pool" do
    assert_difference('Fundamental::ResourcePool.count', -1) do
      delete :destroy, id: @fundamental_resource_pool.to_param
    end

    assert_redirected_to fundamental_resource_pools_path
  end
end
