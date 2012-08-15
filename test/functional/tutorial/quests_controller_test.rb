require 'test_helper'

class Tutorial::QuestsControllerTest < ActionController::TestCase
  setup do
    @tutorial_quest = tutorial_quests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tutorial_quests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tutorial_quest" do
    assert_difference('Tutorial::Quest.count') do
      post :create, tutorial_quest: @tutorial_quest.attributes
    end

    assert_redirected_to tutorial_quest_path(assigns(:tutorial_quest))
  end

  test "should show tutorial_quest" do
    get :show, id: @tutorial_quest.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tutorial_quest.to_param
    assert_response :success
  end

  test "should update tutorial_quest" do
    put :update, id: @tutorial_quest.to_param, tutorial_quest: @tutorial_quest.attributes
    assert_redirected_to tutorial_quest_path(assigns(:tutorial_quest))
  end

  test "should destroy tutorial_quest" do
    assert_difference('Tutorial::Quest.count', -1) do
      delete :destroy, id: @tutorial_quest.to_param
    end

    assert_redirected_to tutorial_quests_path
  end
end
