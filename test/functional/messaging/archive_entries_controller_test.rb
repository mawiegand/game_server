require 'test_helper'

class Messaging::ArchiveEntriesControllerTest < ActionController::TestCase
  setup do
    @messaging_archive_entry = messaging_archive_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messaging_archive_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create messaging_archive_entry" do
    assert_difference('Messaging::ArchiveEntry.count') do
      post :create, messaging_archive_entry: @messaging_archive_entry.attributes
    end

    assert_redirected_to messaging_archive_entry_path(assigns(:messaging_archive_entry))
  end

  test "should show messaging_archive_entry" do
    get :show, id: @messaging_archive_entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messaging_archive_entry.to_param
    assert_response :success
  end

  test "should update messaging_archive_entry" do
    put :update, id: @messaging_archive_entry.to_param, messaging_archive_entry: @messaging_archive_entry.attributes
    assert_redirected_to messaging_archive_entry_path(assigns(:messaging_archive_entry))
  end

  test "should destroy messaging_archive_entry" do
    assert_difference('Messaging::ArchiveEntry.count', -1) do
      delete :destroy, id: @messaging_archive_entry.to_param
    end

    assert_redirected_to messaging_archive_entries_path
  end
end
