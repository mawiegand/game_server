require 'test_helper'

class Fundamental::AlliancesControllerTest < ActionController::TestCase
  setup do
    @fundamental_alliance = fundamental_alliances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_alliances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_alliance" do
    assert_difference('Fundamental::Alliance.count') do
      post :create, fundamental_alliance: @fundamental_alliance.attributes
    end

    assert_redirected_to fundamental_alliance_path(assigns(:fundamental_alliance))
  end

  test "should show fundamental_alliance" do
    get :show, id: @fundamental_alliance.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_alliance.to_param
    assert_response :success
  end

  test "should update fundamental_alliance" do
    put :update, id: @fundamental_alliance.to_param, fundamental_alliance: @fundamental_alliance.attributes
    assert_redirected_to fundamental_alliance_path(assigns(:fundamental_alliance))
  end

  test "should destroy fundamental_alliance" do
    assert_difference('Fundamental::Alliance.count', -1) do
      delete :destroy, id: @fundamental_alliance.to_param
    end

    assert_redirected_to fundamental_alliances_path
  end
end
