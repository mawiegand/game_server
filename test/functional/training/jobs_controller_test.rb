require 'test_helper'

class Training::JobsControllerTest < ActionController::TestCase
  setup do
    @training_job = training_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:training_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create training_job" do
    assert_difference('Training::Job.count') do
      post :create, training_job: @training_job.attributes
    end

    assert_redirected_to training_job_path(assigns(:training_job))
  end

  test "should show training_job" do
    get :show, id: @training_job.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @training_job.to_param
    assert_response :success
  end

  test "should update training_job" do
    put :update, id: @training_job.to_param, training_job: @training_job.attributes
    assert_redirected_to training_job_path(assigns(:training_job))
  end

  test "should destroy training_job" do
    assert_difference('Training::Job.count', -1) do
      delete :destroy, id: @training_job.to_param
    end

    assert_redirected_to training_jobs_path
  end
end
