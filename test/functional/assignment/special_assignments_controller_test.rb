require 'test_helper'

class Assignment::SpecialAssignmentsControllerTest < ActionController::TestCase
  setup do
    @assignment_special_assignment = assignment_special_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignment_special_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assignment_special_assignment" do
    assert_difference('Assignment::SpecialAssignment.count') do
      post :create, assignment_special_assignment: @assignment_special_assignment.attributes
    end

    assert_redirected_to assignment_special_assignment_path(assigns(:assignment_special_assignment))
  end

  test "should show assignment_special_assignment" do
    get :show, id: @assignment_special_assignment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assignment_special_assignment.to_param
    assert_response :success
  end

  test "should update assignment_special_assignment" do
    put :update, id: @assignment_special_assignment.to_param, assignment_special_assignment: @assignment_special_assignment.attributes
    assert_redirected_to assignment_special_assignment_path(assigns(:assignment_special_assignment))
  end

  test "should destroy assignment_special_assignment" do
    assert_difference('Assignment::SpecialAssignment.count', -1) do
      delete :destroy, id: @assignment_special_assignment.to_param
    end

    assert_redirected_to assignment_special_assignments_path
  end
end
