require 'test_helper'

class Fundamental::AnnouncementsControllerTest < ActionController::TestCase
  setup do
    @fundamental_announcement = fundamental_announcements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_announcements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_announcement" do
    assert_difference('Fundamental::Announcement.count') do
      post :create, fundamental_announcement: @fundamental_announcement.attributes
    end

    assert_redirected_to fundamental_announcement_path(assigns(:fundamental_announcement))
  end

  test "should show fundamental_announcement" do
    get :show, id: @fundamental_announcement.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_announcement.to_param
    assert_response :success
  end

  test "should update fundamental_announcement" do
    put :update, id: @fundamental_announcement.to_param, fundamental_announcement: @fundamental_announcement.attributes
    assert_redirected_to fundamental_announcement_path(assigns(:fundamental_announcement))
  end

  test "should destroy fundamental_announcement" do
    assert_difference('Fundamental::Announcement.count', -1) do
      delete :destroy, id: @fundamental_announcement.to_param
    end

    assert_redirected_to fundamental_announcements_path
  end
end
