require 'test_helper'

class Messaging::ArchivesControllerTest < ActionController::TestCase
  setup do
    @messaging_archive = messaging_archives(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messaging_archives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create messaging_archive" do
    assert_difference('Messaging::Archive.count') do
      post :create, messaging_archive: @messaging_archive.attributes
    end

    assert_redirected_to messaging_archive_path(assigns(:messaging_archive))
  end

  test "should show messaging_archive" do
    get :show, id: @messaging_archive.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messaging_archive.to_param
    assert_response :success
  end

  test "should update messaging_archive" do
    put :update, id: @messaging_archive.to_param, messaging_archive: @messaging_archive.attributes
    assert_redirected_to messaging_archive_path(assigns(:messaging_archive))
  end

  test "should destroy messaging_archive" do
    assert_difference('Messaging::Archive.count', -1) do
      delete :destroy, id: @messaging_archive.to_param
    end

    assert_redirected_to messaging_archives_path
  end
end
