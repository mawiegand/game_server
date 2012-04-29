require 'test_helper'

class Military::ArmyDetailsControllerTest < ActionController::TestCase
  setup do
    @military_army_detail = military_army_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:military_army_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create military_army_detail" do
    assert_difference('Military::ArmyDetail.count') do
      post :create, military_army_detail: @military_army_detail.attributes
    end

    assert_redirected_to military_army_detail_path(assigns(:military_army_detail))
  end

  test "should show military_army_detail" do
    get :show, id: @military_army_detail.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @military_army_detail.to_param
    assert_response :success
  end

  test "should update military_army_detail" do
    put :update, id: @military_army_detail.to_param, military_army_detail: @military_army_detail.attributes
    assert_redirected_to military_army_detail_path(assigns(:military_army_detail))
  end

  test "should destroy military_army_detail" do
    assert_difference('Military::ArmyDetail.count', -1) do
      delete :destroy, id: @military_army_detail.to_param
    end

    assert_redirected_to military_army_details_path
  end
end
