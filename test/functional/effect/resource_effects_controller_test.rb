require 'test_helper'

class Effect::ResourceEffectsControllerTest < ActionController::TestCase
  setup do
    @effect_resource_effect = effect_resource_effects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:effect_resource_effects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create effect_resource_effect" do
    assert_difference('Effect::ResourceEffect.count') do
      post :create, effect_resource_effect: @effect_resource_effect.attributes
    end

    assert_redirected_to effect_resource_effect_path(assigns(:effect_resource_effect))
  end

  test "should show effect_resource_effect" do
    get :show, id: @effect_resource_effect.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @effect_resource_effect.to_param
    assert_response :success
  end

  test "should update effect_resource_effect" do
    put :update, id: @effect_resource_effect.to_param, effect_resource_effect: @effect_resource_effect.attributes
    assert_redirected_to effect_resource_effect_path(assigns(:effect_resource_effect))
  end

  test "should destroy effect_resource_effect" do
    assert_difference('Effect::ResourceEffect.count', -1) do
      delete :destroy, id: @effect_resource_effect.to_param
    end

    assert_redirected_to effect_resource_effects_path
  end
end
