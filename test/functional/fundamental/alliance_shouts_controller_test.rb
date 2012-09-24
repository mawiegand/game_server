require 'test_helper'

class Fundamental::AllianceShoutsControllerTest < ActionController::TestCase
  setup do
    @fundamental_alliance_shout = fundamental_alliance_shouts(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_alliance_shouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_alliance_shout" do
    assert_difference('Fundamental::AllianceShout.count') do
      post :create, fundamental_alliance_shout: @fundamental_alliance_shout.attributes
    end

    assert_redirected_to fundamental_alliance_shout_path(assigns(:fundamental_alliance_shout))
  end

  test "should show fundamental_alliance_shout" do
    get :show, id: @fundamental_alliance_shout.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_alliance_shout.to_param
    assert_response :success
  end

  test "should update fundamental_alliance_shout" do
    put :update, id: @fundamental_alliance_shout.to_param, fundamental_alliance_shout: @fundamental_alliance_shout.attributes
    assert_redirected_to fundamental_alliance_shout_path(assigns(:fundamental_alliance_shout))
  end

  test "should destroy fundamental_alliance_shout" do
    assert_difference('Fundamental::AllianceShout.count', -1) do
      delete :destroy, id: @fundamental_alliance_shout.to_param
    end

    assert_redirected_to fundamental_alliance_shouts_path
  end
end
