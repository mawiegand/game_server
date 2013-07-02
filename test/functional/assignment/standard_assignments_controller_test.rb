require 'test_helper'

class Assignment::StandardAssignmentsControllerTest < ActionController::TestCase
  setup do
    @assignment_standard_assignment = assignment_standard_assignments(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignment_standard_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assignment_standard_assignment" do
    assert_difference('Assignment::StandardAssignment.count') do
      post :create, assignment_standard_assignment: @assignment_standard_assignment.attributes
    end

    assert_redirected_to assignment_standard_assignment_path(assigns(:assignment_standard_assignment))
  end

  test "should show assignment_standard_assignment" do
    get :show, id: @assignment_standard_assignment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assignment_standard_assignment.to_param
    assert_response :success
  end

  test "should update assignment_standard_assignment" do
    put :update, id: @assignment_standard_assignment.to_param, assignment_standard_assignment: @assignment_standard_assignment.attributes
    assert_redirected_to assignment_standard_assignment_path(assigns(:assignment_standard_assignment))
  end

  test "should destroy assignment_standard_assignment" do
    assert_difference('Assignment::StandardAssignment.count', -1) do
      delete :destroy, id: @assignment_standard_assignment.to_param
    end

    assert_redirected_to assignment_standard_assignments_path
  end
end
