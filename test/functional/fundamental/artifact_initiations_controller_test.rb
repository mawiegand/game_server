require 'test_helper'

class Fundamental::ArtifactInitiationsControllerTest < ActionController::TestCase
  setup do
    @fundamental_artifact_initiation = fundamental_artifact_initiations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_artifact_initiations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_artifact_initiation" do
    assert_difference('Fundamental::ArtifactInitiation.count') do
      post :create, fundamental_artifact_initiation: @fundamental_artifact_initiation.attributes
    end

    assert_redirected_to fundamental_artifact_initiation_path(assigns(:fundamental_artifact_initiation))
  end

  test "should show fundamental_artifact_initiation" do
    get :show, id: @fundamental_artifact_initiation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_artifact_initiation.to_param
    assert_response :success
  end

  test "should update fundamental_artifact_initiation" do
    put :update, id: @fundamental_artifact_initiation.to_param, fundamental_artifact_initiation: @fundamental_artifact_initiation.attributes
    assert_redirected_to fundamental_artifact_initiation_path(assigns(:fundamental_artifact_initiation))
  end

  test "should destroy fundamental_artifact_initiation" do
    assert_difference('Fundamental::ArtifactInitiation.count', -1) do
      delete :destroy, id: @fundamental_artifact_initiation.to_param
    end

    assert_redirected_to fundamental_artifact_initiations_path
  end
end
