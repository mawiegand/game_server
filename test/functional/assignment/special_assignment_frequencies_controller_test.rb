require 'test_helper'

class Assignment::SpecialAssignmentFrequenciesControllerTest < ActionController::TestCase
  setup do
    @assignment_special_assignment_frequency = assignment_special_assignment_frequencies(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignment_special_assignment_frequencies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assignment_special_assignment_frequency" do
    assert_difference('Assignment::SpecialAssignmentFrequency.count') do
      post :create, assignment_special_assignment_frequency: @assignment_special_assignment_frequency.attributes
    end

    assert_redirected_to assignment_special_assignment_frequency_path(assigns(:assignment_special_assignment_frequency))
  end

  test "should show assignment_special_assignment_frequency" do
    get :show, id: @assignment_special_assignment_frequency.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assignment_special_assignment_frequency.to_param
    assert_response :success
  end

  test "should update assignment_special_assignment_frequency" do
    put :update, id: @assignment_special_assignment_frequency.to_param, assignment_special_assignment_frequency: @assignment_special_assignment_frequency.attributes
    assert_redirected_to assignment_special_assignment_frequency_path(assigns(:assignment_special_assignment_frequency))
  end

  test "should destroy assignment_special_assignment_frequency" do
    assert_difference('Assignment::SpecialAssignmentFrequency.count', -1) do
      delete :destroy, id: @assignment_special_assignment_frequency.to_param
    end

    assert_redirected_to assignment_special_assignment_frequencies_path
  end
end
