require 'test_helper'

class Map::NodesControllerTest < ActionController::TestCase
  setup do
    @map_node = map_nodes(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:map_nodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

 # test "should create map_node" do
 #    assert_difference('Map::Node.count') do
 #     post :create, map_node: @map_node.attributes
#    end
#
#    assert_redirected_to map_node_path(assigns(:map_node))
 # end

  test "should show map_node" do
    get :show, id: @map_node.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @map_node.to_param
    assert_response :success
  end

#  test "should update map_node" do
#    put :update, id: @map_node.to_param, map_node: @map_node.attributes
#    assert_redirected_to map_node_path(assigns(:map_node))
#  end

#  test "should destroy map_node" do
#    assert_difference('Map::Node.count', -1) do
#      delete :destroy, id: @map_node.to_param
#    end

#    assert_redirected_to map_nodes_path
#  end
end
