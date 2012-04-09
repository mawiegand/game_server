require 'test_helper'

class Fundamental::CharactersControllerTest < ActionController::TestCase
  setup do
    @fundamental_character = fundamental_characters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_characters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_character" do
    assert_difference('Fundamental::Character.count') do
      post :create, fundamental_character: @fundamental_character.attributes
    end

    assert_redirected_to fundamental_character_path(assigns(:fundamental_character))
  end

  test "should show fundamental_character" do
    get :show, id: @fundamental_character.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_character.to_param
    assert_response :success
  end

  test "should update fundamental_character" do
    put :update, id: @fundamental_character.to_param, fundamental_character: @fundamental_character.attributes
    assert_redirected_to fundamental_character_path(assigns(:fundamental_character))
  end

  test "should destroy fundamental_character" do
    assert_difference('Fundamental::Character.count', -1) do
      delete :destroy, id: @fundamental_character.to_param
    end

    assert_redirected_to fundamental_characters_path
  end
end
