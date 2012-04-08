require 'test_helper'

class Events::EventsControllerTest < ActionController::TestCase
  setup do
    @events_event = events_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create events_event" do
    assert_difference('Events::Event.count') do
      post :create, events_event: @events_event.attributes
    end

    assert_redirected_to events_event_path(assigns(:events_event))
  end

  test "should show events_event" do
    get :show, id: @events_event.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @events_event.to_param
    assert_response :success
  end

  test "should update events_event" do
    put :update, id: @events_event.to_param, events_event: @events_event.attributes
    assert_redirected_to events_event_path(assigns(:events_event))
  end

  test "should destroy events_event" do
    assert_difference('Events::Event.count', -1) do
      delete :destroy, id: @events_event.to_param
    end

    assert_redirected_to events_events_path
  end
end
