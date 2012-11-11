require 'test_helper'

class Construction::JobsControllerTest < ActionController::TestCase
  setup do
    @construction_job = construction_jobs(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

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


  # test "should show construction_job" do
    # get :show, id: @construction_job.to_param
    # assert_response :success
  # end

  test "should get edit" do
    get :edit, id: @construction_job.to_param
    assert_response :success
  end

  test "should update construction_job" do
    put :update, id: @construction_job.to_param, construction_job: @construction_job.attributes
    assert_redirected_to construction_job_path(assigns(:construction_job))
  end

end
