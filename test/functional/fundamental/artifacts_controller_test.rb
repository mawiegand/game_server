require 'test_helper'

class Fundamental::ArtifactsControllerTest < ActionController::TestCase
  setup do
    @fundamental_artifact = fundamental_artifacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_artifacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_artifact" do
    assert_difference('Fundamental::Artifact.count') do
      post :create, fundamental_artifact: @fundamental_artifact.attributes
    end

    assert_redirected_to fundamental_artifact_path(assigns(:fundamental_artifact))
  end

  test "should show fundamental_artifact" do
    get :show, id: @fundamental_artifact.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_artifact.to_param
    assert_response :success
  end

  test "should update fundamental_artifact" do
    put :update, id: @fundamental_artifact.to_param, fundamental_artifact: @fundamental_artifact.attributes
    assert_redirected_to fundamental_artifact_path(assigns(:fundamental_artifact))
  end

  test "should destroy fundamental_artifact" do
    assert_difference('Fundamental::Artifact.count', -1) do
      delete :destroy, id: @fundamental_artifact.to_param
    end

    assert_redirected_to fundamental_artifacts_path
  end
end
