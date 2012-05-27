require 'test_helper'

class Construction::JobsControllerTest < ActionController::TestCase
  setup do
    @construction_job = construction_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:construction_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create construction_job" do
    assert_difference('Construction::Job.count') do
      post :create, construction_job: @construction_job.attributes
    end

    assert_redirected_to construction_job_path(assigns(:construction_job))
  end

  test "should show construction_job" do
    get :show, id: @construction_job.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @construction_job.to_param
    assert_response :success
  end

  test "should update construction_job" do
    put :update, id: @construction_job.to_param, construction_job: @construction_job.attributes
    assert_redirected_to construction_job_path(assigns(:construction_job))
  end

  test "should destroy construction_job" do
    assert_difference('Construction::Job.count', -1) do
      delete :destroy, id: @construction_job.to_param
    end

    assert_redirected_to construction_jobs_path
  end
end
