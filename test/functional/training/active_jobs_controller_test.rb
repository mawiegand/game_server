require 'test_helper'

class Training::ActiveJobsControllerTest < ActionController::TestCase
  setup do
    @training_active_job = training_active_jobs(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:training_active_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create training_active_job" do
    assert_difference('Training::ActiveJob.count') do
      post :create, training_active_job: @training_active_job.attributes
    end

    assert_redirected_to training_active_job_path(assigns(:training_active_job))
  end

  test "should show training_active_job" do
    get :show, id: @training_active_job.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @training_active_job.to_param
    assert_response :success
  end

  test "should update training_active_job" do
    put :update, id: @training_active_job.to_param, training_active_job: @training_active_job.attributes
    assert_redirected_to training_active_job_path(assigns(:training_active_job))
  end

  test "should destroy training_active_job" do
    assert_difference('Training::ActiveJob.count', -1) do
      delete :destroy, id: @training_active_job.to_param
    end

    assert_redirected_to training_active_jobs_path
  end
end
