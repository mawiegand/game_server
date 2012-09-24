require 'test_helper'

class Fundamental::SettingsControllerTest < ActionController::TestCase
  setup do
    @fundamental_setting = fundamental_settings(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_setting" do
    assert_difference('Fundamental::Setting.count') do
      post :create, fundamental_setting: @fundamental_setting.attributes
    end

    assert_redirected_to fundamental_setting_path(assigns(:fundamental_setting))
  end

  test "should show fundamental_setting" do
    get :show, id: @fundamental_setting.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_setting.to_param
    assert_response :success
  end

  test "should update fundamental_setting" do
    put :update, id: @fundamental_setting.to_param, fundamental_setting: @fundamental_setting.attributes
    assert_redirected_to fundamental_setting_path(assigns(:fundamental_setting))
  end

  test "should destroy fundamental_setting" do
    assert_difference('Fundamental::Setting.count', -1) do
      delete :destroy, id: @fundamental_setting.to_param
    end

    assert_redirected_to fundamental_settings_path
  end
end
