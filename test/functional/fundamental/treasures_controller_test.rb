require 'test_helper'

class Fundamental::TreasuresControllerTest < ActionController::TestCase
  setup do
    @fundamental_treasure = fundamental_treasures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_treasures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_treasure" do
    assert_difference('Fundamental::Treasure.count') do
      post :create, fundamental_treasure: @fundamental_treasure.attributes
    end

    assert_redirected_to fundamental_treasure_path(assigns(:fundamental_treasure))
  end

  test "should show fundamental_treasure" do
    get :show, id: @fundamental_treasure.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_treasure.to_param
    assert_response :success
  end

  test "should update fundamental_treasure" do
    put :update, id: @fundamental_treasure.to_param, fundamental_treasure: @fundamental_treasure.attributes
    assert_redirected_to fundamental_treasure_path(assigns(:fundamental_treasure))
  end

  test "should destroy fundamental_treasure" do
    assert_difference('Fundamental::Treasure.count', -1) do
      delete :destroy, id: @fundamental_treasure.to_param
    end

    assert_redirected_to fundamental_treasures_path
  end
end
