require 'test_helper'

class Backend::UsersControllerTest < ActionController::TestCase
  setup do
    @backend_user = backend_users(:one)
    @controller.current_backend_user = backend_users(:admin)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backend_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show backend_user" do
    get :show, id: @backend_user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend_user.to_param
    assert_response :success
  end

  test "should update backend_user" do
    put :update, id: @backend_user.to_param, backend_user: @backend_user.attributes
    assert_redirected_to backend_user_path(assigns(:backend_user))
  end


end
