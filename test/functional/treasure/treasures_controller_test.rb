require 'test_helper'

class Treasure::TreasuresControllerTest < ActionController::TestCase
  setup do
    @treasure_treasure = treasure_treasures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:treasure_treasures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create treasure_treasure" do
    assert_difference('Treasure::Treasure.count') do
      post :create, treasure_treasure: @treasure_treasure.attributes
    end

    assert_redirected_to treasure_treasure_path(assigns(:treasure_treasure))
  end

  test "should show treasure_treasure" do
    get :show, id: @treasure_treasure.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @treasure_treasure.to_param
    assert_response :success
  end

  test "should update treasure_treasure" do
    put :update, id: @treasure_treasure.to_param, treasure_treasure: @treasure_treasure.attributes
    assert_redirected_to treasure_treasure_path(assigns(:treasure_treasure))
  end

  test "should destroy treasure_treasure" do
    assert_difference('Treasure::Treasure.count', -1) do
      delete :destroy, id: @treasure_treasure.to_param
    end

    assert_redirected_to treasure_treasures_path
  end
end
