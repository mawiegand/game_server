require 'test_helper'

class Facebook::AppConfigsControllerTest < ActionController::TestCase
  setup do
    @facebook_app_config = facebook_app_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facebook_app_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facebook_app_config" do
    assert_difference('Facebook::AppConfig.count') do
      post :create, facebook_app_config: @facebook_app_config.attributes
    end

    assert_redirected_to facebook_app_config_path(assigns(:facebook_app_config))
  end

  test "should show facebook_app_config" do
    get :show, id: @facebook_app_config.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facebook_app_config.to_param
    assert_response :success
  end

  test "should update facebook_app_config" do
    put :update, id: @facebook_app_config.to_param, facebook_app_config: @facebook_app_config.attributes
    assert_redirected_to facebook_app_config_path(assigns(:facebook_app_config))
  end

  test "should destroy facebook_app_config" do
    assert_difference('Facebook::AppConfig.count', -1) do
      delete :destroy, id: @facebook_app_config.to_param
    end

    assert_redirected_to facebook_app_configs_path
  end
end
