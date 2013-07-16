require 'test_helper'

class Backend::UserContentReportsControllerTest < ActionController::TestCase
  setup do
    @backend_user_content_report = backend_user_content_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backend_user_content_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backend_user_content_report" do
    assert_difference('Backend::UserContentReport.count') do
      post :create, backend_user_content_report: @backend_user_content_report.attributes
    end

    assert_redirected_to backend_user_content_report_path(assigns(:backend_user_content_report))
  end

  test "should show backend_user_content_report" do
    get :show, id: @backend_user_content_report.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend_user_content_report.to_param
    assert_response :success
  end

  test "should update backend_user_content_report" do
    put :update, id: @backend_user_content_report.to_param, backend_user_content_report: @backend_user_content_report.attributes
    assert_redirected_to backend_user_content_report_path(assigns(:backend_user_content_report))
  end

  test "should destroy backend_user_content_report" do
    assert_difference('Backend::UserContentReport.count', -1) do
      delete :destroy, id: @backend_user_content_report.to_param
    end

    assert_redirected_to backend_user_content_reports_path
  end
end
