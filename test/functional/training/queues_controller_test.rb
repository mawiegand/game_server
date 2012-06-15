require 'test_helper'

class Training::QueuesControllerTest < ActionController::TestCase
  setup do
    @training_queue = training_queues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:training_queues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create training_queue" do
    assert_difference('Training::Queue.count') do
      post :create, training_queue: @training_queue.attributes
    end

    assert_redirected_to training_queue_path(assigns(:training_queue))
  end

  test "should show training_queue" do
    get :show, id: @training_queue.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @training_queue.to_param
    assert_response :success
  end

  test "should update training_queue" do
    put :update, id: @training_queue.to_param, training_queue: @training_queue.attributes
    assert_redirected_to training_queue_path(assigns(:training_queue))
  end

  test "should destroy training_queue" do
    assert_difference('Training::Queue.count', -1) do
      delete :destroy, id: @training_queue.to_param
    end

    assert_redirected_to training_queues_path
  end
end
