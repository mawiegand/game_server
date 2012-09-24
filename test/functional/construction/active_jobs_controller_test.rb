require 'test_helper'

class Construction::ActiveJobsControllerTest < ActionController::TestCase
  setup do
    @construction_active_job = construction_active_jobs(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:construction_active_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create construction_active_job" do
    assert_difference('Construction::ActiveJob.count') do
      post :create, construction_active_job: @construction_active_job.attributes
    end

    assert_redirected_to construction_active_job_path(assigns(:construction_active_job))
  end

  test "should show construction_active_job" do
    get :show, id: @construction_active_job.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @construction_active_job.to_param
    assert_response :success
  end

  test "should update construction_active_job" do
    put :update, id: @construction_active_job.to_param, construction_active_job: @construction_active_job.attributes
    assert_redirected_to construction_active_job_path(assigns(:construction_active_job))
  end

  test "should destroy construction_active_job" do
    assert_difference('Construction::ActiveJob.count', -1) do
      delete :destroy, id: @construction_active_job.to_param
    end

    assert_redirected_to construction_active_jobs_path
  end
end
