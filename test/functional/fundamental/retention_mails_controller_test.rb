require 'test_helper'

class Fundamental::RetentionMailsControllerTest < ActionController::TestCase
  setup do
    @fundamental_retention_mail = fundamental_retention_mails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_retention_mails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_retention_mail" do
    assert_difference('Fundamental::RetentionMail.count') do
      post :create, fundamental_retention_mail: @fundamental_retention_mail.attributes
    end

    assert_redirected_to fundamental_retention_mail_path(assigns(:fundamental_retention_mail))
  end

  test "should show fundamental_retention_mail" do
    get :show, id: @fundamental_retention_mail.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_retention_mail.to_param
    assert_response :success
  end

  test "should update fundamental_retention_mail" do
    put :update, id: @fundamental_retention_mail.to_param, fundamental_retention_mail: @fundamental_retention_mail.attributes
    assert_redirected_to fundamental_retention_mail_path(assigns(:fundamental_retention_mail))
  end

  test "should destroy fundamental_retention_mail" do
    assert_difference('Fundamental::RetentionMail.count', -1) do
      delete :destroy, id: @fundamental_retention_mail.to_param
    end

    assert_redirected_to fundamental_retention_mails_path
  end
end
