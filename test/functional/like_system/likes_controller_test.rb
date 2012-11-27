require 'test_helper'

class LikeSystem::LikesControllerTest < ActionController::TestCase
  setup do
    @like_system_like = like_system_likes(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:like_system_likes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create like_system_like" do
    assert_difference('LikeSystem::Like.count') do
      post :create, like_system_like: @like_system_like.attributes
    end

    assert_redirected_to like_system_like_path(assigns(:like_system_like))
  end

  test "should show like_system_like" do
    get :show, id: @like_system_like.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @like_system_like.to_param
    assert_response :success
  end

  test "should update like_system_like" do
    put :update, id: @like_system_like.to_param, like_system_like: @like_system_like.attributes
    assert_redirected_to like_system_like_path(assigns(:like_system_like))
  end

  test "should destroy like_system_like" do
    assert_difference('LikeSystem::Like.count', -1) do
      delete :destroy, id: @like_system_like.to_param
    end

    assert_redirected_to like_system_likes_path
  end
end
