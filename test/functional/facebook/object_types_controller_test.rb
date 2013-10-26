require 'test_helper'

class Facebook::ObjectTypesControllerTest < ActionController::TestCase
  setup do
    @facebook_object_type = facebook_object_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facebook_object_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facebook_object_type" do
    assert_difference('Facebook::ObjectType.count') do
      post :create, facebook_object_type: @facebook_object_type.attributes
    end

    assert_redirected_to facebook_object_type_path(assigns(:facebook_object_type))
  end

  test "should show facebook_object_type" do
    get :show, id: @facebook_object_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facebook_object_type.to_param
    assert_response :success
  end

  test "should update facebook_object_type" do
    put :update, id: @facebook_object_type.to_param, facebook_object_type: @facebook_object_type.attributes
    assert_redirected_to facebook_object_type_path(assigns(:facebook_object_type))
  end

  test "should destroy facebook_object_type" do
    assert_difference('Facebook::ObjectType.count', -1) do
      delete :destroy, id: @facebook_object_type.to_param
    end

    assert_redirected_to facebook_object_types_path
  end
end
