require 'test_helper'

class Google::AppConfigsControllerTest < ActionController::TestCase
  setup do
    @google_app_config = google_app_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:google_app_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create google_app_config" do
    assert_difference('Google::AppConfig.count') do
      post :create, google_app_config: @google_app_config.attributes
    end

    assert_redirected_to google_app_config_path(assigns(:google_app_config))
  end

  test "should show google_app_config" do
    get :show, id: @google_app_config.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @google_app_config.to_param
    assert_response :success
  end

  test "should update google_app_config" do
    put :update, id: @google_app_config.to_param, google_app_config: @google_app_config.attributes
    assert_redirected_to google_app_config_path(assigns(:google_app_config))
  end

  test "should destroy google_app_config" do
    assert_difference('Google::AppConfig.count', -1) do
      delete :destroy, id: @google_app_config.to_param
    end

    assert_redirected_to google_app_configs_path
  end
end
