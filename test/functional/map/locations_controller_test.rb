require 'test_helper'

class Map::LocationsControllerTest < ActionController::TestCase
  setup do
    @map_location = map_locations(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:map_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create map_location" do
    assert_difference('Map::Location.count') do
      post :create, map_location: @map_location.attributes
    end

    assert_redirected_to map_location_path(assigns(:map_location))
  end

  test "should show map_location" do
    get :show, id: @map_location.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @map_location.to_param
    assert_response :success
  end

  test "should update map_location" do
    put :update, id: @map_location.to_param, map_location: @map_location.attributes
    assert_redirected_to map_location_path(assigns(:map_location))
  end

  test "should destroy map_location" do
    assert_difference('Map::Location.count', -1) do
      delete :destroy, id: @map_location.to_param
    end

    assert_redirected_to map_locations_path
  end
end
