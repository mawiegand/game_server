require 'test_helper'

class Event::EventsControllerTest < ActionController::TestCase
  setup do
    @event_event = event_events(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create events_event" do
    assert_difference('Event::Event.count') do
      post :create, event_event: @event_event.attributes
    end

    assert_redirected_to event_event_path(assigns(:event_event))
  end

  test "should show events_event" do
    get :show, id: @event_event.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_event.to_param
    assert_response :success
  end

  test "should update events_event" do
    put :update, id: @event_event.to_param, events_event: @event_event.attributes
    assert_redirected_to event_event_path(assigns(:event_event))
  end

  test "should destroy events_event" do
    assert_difference('Event::Event.count', -1) do
      delete :destroy, id: @event_event.to_param
    end

    assert_redirected_to event_events_path
  end
end
