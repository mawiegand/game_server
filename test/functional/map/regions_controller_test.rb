require 'test_helper'

class Map::RegionsControllerTest < ActionController::TestCase
  setup do
    @map_region = map_regions(:one)
    @fundamental_round_info = fundamental_round_infos(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:map_regions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create map_region" do
    assert_difference('Map::Region.count') do
      post :create, map_region: @map_region.attributes
    end

    assert_redirected_to map_region_path(assigns(:map_region))
  end

  test "should show map_region" do
    get :show, id: @map_region.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @map_region.to_param
    assert_response :success
  end

  test "should update map_region" do
    put :update, id: @map_region.to_param, map_region: @map_region.attributes
    assert_redirected_to map_region_path(assigns(:map_region))
  end

  test "should destroy map_region" do
    assert_difference('Map::Region.count', -1) do
      delete :destroy, id: @map_region.to_param
    end

    assert_redirected_to map_regions_path
  end
end
