require 'test_helper'

class Fundamental::DiplomacyRelationsControllerTest < ActionController::TestCase
  setup do
    @fundamental_diplomacy_relation = fundamental_diplomacy_relations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundamental_diplomacy_relations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fundamental_diplomacy_relation" do
    assert_difference('Fundamental::DiplomacyRelation.count') do
      post :create, fundamental_diplomacy_relation: @fundamental_diplomacy_relation.attributes
    end

    assert_redirected_to fundamental_diplomacy_relation_path(assigns(:fundamental_diplomacy_relation))
  end

  test "should show fundamental_diplomacy_relation" do
    get :show, id: @fundamental_diplomacy_relation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fundamental_diplomacy_relation.to_param
    assert_response :success
  end

  test "should update fundamental_diplomacy_relation" do
    put :update, id: @fundamental_diplomacy_relation.to_param, fundamental_diplomacy_relation: @fundamental_diplomacy_relation.attributes
    assert_redirected_to fundamental_diplomacy_relation_path(assigns(:fundamental_diplomacy_relation))
  end

  test "should destroy fundamental_diplomacy_relation" do
    assert_difference('Fundamental::DiplomacyRelation.count', -1) do
      delete :destroy, id: @fundamental_diplomacy_relation.to_param
    end

    assert_redirected_to fundamental_diplomacy_relations_path
  end
end
