require 'test_helper'

class Tutorial::StatesControllerTest < ActionController::TestCase
  setup do
    @tutorial_state = tutorial_states(:one)
  end
  
  # ##########################################################################
  #
  #   API SPECIFIC TESTS 
  #
  # ##########################################################################

  # SHOW   : accessible via API

  test "should show tutorial_state via API access" do
    @controller.current_character = @tutorial_state.owner
    
    get :show, id: @tutorial_state.to_param, format: "json"
    assert_response :success
  end

  test "should return not found for missing resources via API access" do
    @controller.current_character = @tutorial_state.owner
    get :show, id: -1, format: "json"
    assert_response :not_found
  end  

  test "should not show tutorial_state via unauthorized API access" do
    get :show, id: @tutorial_state.to_param, format: "json"
    assert_response :unauthorized   

    @controller.current_character = fundamental_characters(:ally)
    get :show, id: @tutorial_state.to_param, format: "json"
    assert_response :forbidden      
  end 


  # DELETE : not accessible via API

  test "should not destroy tutorial_state via API access" do
    assert_difference('Tutorial::State.count', 0) do
      delete :destroy, id: @tutorial_state.to_param, format: "json"
    end
    assert_response :unauthorized

    @controller.current_character =  @tutorial_state.owner
    assert_difference('Tutorial::State.count', 0) do
      delete :destroy, id: @tutorial_state.to_param, format: "json"
    end
    assert_response :forbidden  

    @controller.current_character = nil
    @controller.current_backend_user = backend_users(:admin)   # although somehow "achieved" backend user state, API should fail
    
    assert_difference('Tutorial::State.count', 0) do
      delete :destroy, id: @tutorial_state.to_param, format: "json"
    end
    assert_response :unauthorized  
  end  

  # CREATE : not accessible via API

  test "should not get new on API access" do
    get :new, format: "json"
    assert_response :unauthorized

    @controller.current_character =  @tutorial_state.owner    
    get :new, format: "json"
    assert_response :forbidden
  end

  test "should not create tutorial_state on API access" do
    assert_difference('Tutorial::State.count', 0) do
      post :create, tutorial_state: @tutorial_state.attributes, format: "json"
    end
    assert_response :unauthorized 

    @controller.current_character =  @tutorial_state.owner    
    assert_difference('Tutorial::State.count', 0) do
      post :create, tutorial_state: @tutorial_state.attributes, format: "json"
    end
    assert_response :forbidden
  end

  # UPDATE : not accessible via API
  
  test "should not get edit on API access" do
    get :edit, id: @tutorial_state.to_param, format: "json"
    assert_response :unauthorized

    @controller.current_character =  @tutorial_state.owner    

    get :edit, id: @tutorial_state.to_param, format: "json"
    assert_response :forbidden
  end

  
  test "should not update tutorial_state on API access" do
    put :update, id: @tutorial_state.to_param, tutorial_state: @tutorial_state.attributes, format: "json"
    assert_response :unauthorized

    @controller.current_character =  @tutorial_state.owner    
    
    put :update, id: @tutorial_state.to_param, tutorial_state: @tutorial_state.attributes, format: "json"
    assert_response :forbidden
  end

  # INDEX  : not accessible via API

  test "should not get index via API access" do
    get :index, format: "json"
    assert_response :unauthorized

    @controller.current_character =  fundamental_characters(:owner)    
    get :index, format: "json"
    assert_response :forbidden
  end

  # ##########################################################################
  #
  #   BACKEND TESTS AND GENERAL FUNCTIONAL TESTS
  #
  # ##########################################################################

  test "should get index" do
    @controller.current_backend_user = backend_users(:staff)

    get :index
    assert_response :success
    assert_not_nil assigns(:tutorial_states)
  end

  test "should not get index on unauthorized access" do
    get :index
    assert_response :forbidden

    @controller.current_backend_user = backend_users(:user)
    
    get :index
    assert_response :forbidden
  end

  test "should get new" do
    @controller.current_backend_user = backend_users(:staff)

    get :new
    assert_response :success
  end
  
  test "should not get new on unauthorized access" do
    get :new
    assert_response :forbidden

    @controller.current_backend_user = backend_users(:user)

    get :new
    assert_response :forbidden
  end

  test "should create tutorial_state" do
    @controller.current_backend_user = backend_users(:staff)

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

    assert_difference('Tutorial::State.count', 0) do
      post :create, tutorial_state: @tutorial_state.attributes
    end

    assert_response :forbidden
  end


  test "should show tutorial_state to staff" do
    @controller.current_backend_user = backend_users(:staff)

    get :show, id: @tutorial_state.to_param
    assert_response :success
  end
  
  test "should not show tutorial_state for unauthorized access" do
    get :show, id: @tutorial_state.to_param
    assert_response :forbidden
  end

  test "should get edit" do
    @controller.current_backend_user = backend_users(:staff)

    get :edit, id: @tutorial_state.to_param
    assert_response :success
  end
  
  test "should not get edit on unauthorized access" do
    get :edit, id: @tutorial_state.to_param
    assert_response :forbidden

    @controller.current_backend_user = backend_users(:user)

    get :edit, id: @tutorial_state.to_param
    assert_response :forbidden
  end

  test "should update tutorial_state" do
    @controller.current_backend_user = backend_users(:staff)

    put :update, id: @tutorial_state.to_param, tutorial_state: @tutorial_state.attributes
    assert_redirected_to tutorial_state_path(assigns(:tutorial_state))
  end
  
  test "should not update tutorial_state on unauthorized access" do
    put :update, id: @tutorial_state.to_param, tutorial_state: @tutorial_state.attributes
    assert_response :forbidden

    @controller.current_backend_user = backend_users(:user)

    put :update, id: @tutorial_state.to_param, tutorial_state: @tutorial_state.attributes
    assert_response :forbidden
  end

  test "should destroy tutorial_state" do
    @controller.current_backend_user = backend_users(:staff)

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
    
    assert_difference('Tutorial::State.count', 0) do
      delete :destroy, id: @tutorial_state.to_param
    end
    assert_response :forbidden    
  end
  

  
end
