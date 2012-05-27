require 'test_helper'

class Construction::QueuesControllerTest < ActionController::TestCase
  setup do
    @construction_queue = construction_queues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:construction_queues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create construction_queue" do
    assert_difference('Construction::Queue.count') do
      post :create, construction_queue: @construction_queue.attributes
    end

    assert_redirected_to construction_queue_path(assigns(:construction_queue))
  end

  test "should show construction_queue" do
    get :show, id: @construction_queue.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @construction_queue.to_param
    assert_response :success
  end

  test "should update construction_queue" do
    put :update, id: @construction_queue.to_param, construction_queue: @construction_queue.attributes
    assert_redirected_to construction_queue_path(assigns(:construction_queue))
  end

  test "should destroy construction_queue" do
    assert_difference('Construction::Queue.count', -1) do
      delete :destroy, id: @construction_queue.to_param
    end

    assert_redirected_to construction_queues_path
  end
end
