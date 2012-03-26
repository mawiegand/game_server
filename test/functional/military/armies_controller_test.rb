require 'test_helper'

class Military::ArmiesControllerTest < ActionController::TestCase
  setup do
    @military_army = military_armies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:military_armies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create military_army" do
    assert_difference('Military::Army.count') do
      post :create, military_army: @military_army.attributes
    end

    assert_redirected_to military_army_path(assigns(:military_army))
  end

  test "should show military_army" do
    get :show, id: @military_army.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @military_army.to_param
    assert_response :success
  end

  test "should update military_army" do
    put :update, id: @military_army.to_param, military_army: @military_army.attributes
    assert_redirected_to military_army_path(assigns(:military_army))
  end

  test "should destroy military_army" do
    assert_difference('Military::Army.count', -1) do
      delete :destroy, id: @military_army.to_param
    end

    assert_redirected_to military_armies_path
  end
end
