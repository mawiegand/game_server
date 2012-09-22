require 'test_helper'

class Tutorial::StatesControllerTest < ActionController::TestCase
  setup do
    @tutorial_state = tutorial_states(:one)
  end

  test "should get index" do
    @controller.current_backend_user = backend_users(:staff)
    puts @controller.current_backend_user.inspect    
    
    get :index
    assert_response :success
    assert_not_nil assigns(:tutorial_states)
  end

  test "should not get index on unauthorized access" do
    get :index
    assert_response :forbidden

    @controller.current_backend_user = backend_users(:user)
    puts @controller.current_backend_user.inspect    
    
    get :index
    assert_response :forbidden
  end

  test "should get new" do
    @controller.current_backend_user = backend_users(:staff)
    puts @controller.current_backend_user.inspect    

    get :new
    assert_response :success
  end
  
  test "should not get new on unauthorized access" do
    get :new
    assert_response :forbidden

    @controller.current_backend_user = backend_users(:user)
    puts @controller.current_backend_user.inspect    

    get :new
    assert_response :forbidden
  end

  test "should create tutorial_state" do
    @controller.current_backend_user = backend_users(:staff)
    puts @controller.current_backend_user.inspect    

    assert_difference('Tutorial::State.count') do
      post :create, tutorial_state: @tutorial_state.attributes
    end

    assert_redirected_to tutorial_state_path(assigns(:tutorial_state))
  end

  test "should not create tutorial_state on unauthorized access" do
    assert_difference('Tutorial::State.count', 0) do
      post :create, tutorial_state: @tutorial_state.attributes
    end

    @controller.current_backend_user = backend_users(:user)
    puts @controller.current_backend_user.inspect    

    assert_difference('Tutorial::State.count', 0) do
      post :create, tutorial_state: @tutorial_state.attributes
    end

    assert_response :forbidden
  end


  test "should show tutorial_state to users" do
    @controller.current_backend_user = backend_users(:user)
    puts @controller.current_backend_user.inspect    

    get :show, id: @tutorial_state.to_param
    assert_response :success
  end
  
  test "should not show tutorial_state for unauthorized access" do
    get :show, id: @tutorial_state.to_param
    assert_response :forbidden
  end

  test "should get edit" do
    @controller.current_backend_user = backend_users(:staff)
    puts @controller.current_backend_user.inspect    

    get :edit, id: @tutorial_state.to_param
    assert_response :success
  end
  
  test "should not get edit on unauthorized access" do
    get :edit, id: @tutorial_state.to_param
    assert_response :forbidden

    @controller.current_backend_user = backend_users(:user)
    puts @controller.current_backend_user.inspect    

    get :edit, id: @tutorial_state.to_param
    assert_response :forbidden
  end

  test "should update tutorial_state" do
    @controller.current_backend_user = backend_users(:staff)
    puts @controller.current_backend_user.inspect    

    put :update, id: @tutorial_state.to_param, tutorial_state: @tutorial_state.attributes
    assert_redirected_to tutorial_state_path(assigns(:tutorial_state))
  end
  
  test "should not update tutorial_state on unauthorized access" do
    put :update, id: @tutorial_state.to_param, tutorial_state: @tutorial_state.attributes
    assert_response :forbidden

    @controller.current_backend_user = backend_users(:user)
    puts @controller.current_backend_user.inspect    

    put :update, id: @tutorial_state.to_param, tutorial_state: @tutorial_state.attributes
    assert_response :forbidden
  end

  test "should destroy tutorial_state" do
    @controller.current_backend_user = backend_users(:staff)
    puts @controller.current_backend_user.inspect    

    assert_difference('Tutorial::State.count', -1) do
      delete :destroy, id: @tutorial_state.to_param
    end

    assert_redirected_to tutorial_states_path
  end
  
  test "should not destroy tutorial_state on unauthorized access" do
    assert_difference('Tutorial::State.count', 0) do
      delete :destroy, id: @tutorial_state.to_param
    end
    assert_response :forbidden

    @controller.current_backend_user = backend_users(:user)
    puts @controller.current_backend_user.inspect    
    
    assert_difference('Tutorial::State.count', 0) do
      delete :destroy, id: @tutorial_state.to_param
    end
    assert_response :forbidden    
  end
  
end
