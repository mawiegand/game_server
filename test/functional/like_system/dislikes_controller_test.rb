require 'test_helper'

class LikeSystem::DislikesControllerTest < ActionController::TestCase
  setup do
    @like_system_dislike = like_system_dislikes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:like_system_dislikes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create like_system_dislike" do
    assert_difference('LikeSystem::Dislike.count') do
      post :create, like_system_dislike: @like_system_dislike.attributes
    end

    assert_redirected_to like_system_dislike_path(assigns(:like_system_dislike))
  end

  test "should show like_system_dislike" do
    get :show, id: @like_system_dislike.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @like_system_dislike.to_param
    assert_response :success
  end

  test "should update like_system_dislike" do
    put :update, id: @like_system_dislike.to_param, like_system_dislike: @like_system_dislike.attributes
    assert_redirected_to like_system_dislike_path(assigns(:like_system_dislike))
  end

  test "should destroy like_system_dislike" do
    assert_difference('LikeSystem::Dislike.count', -1) do
      delete :destroy, id: @like_system_dislike.to_param
    end

    assert_redirected_to like_system_dislikes_path
  end
end
