require 'test_helper'

class Effect::ConstructionEffectsControllerTest < ActionController::TestCase
  setup do
    @effect_construction_effect = effect_construction_effects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:effect_construction_effects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create effect_construction_effect" do
    assert_difference('Effect::ConstructionEffect.count') do
      post :create, effect_construction_effect: @effect_construction_effect.attributes
    end

    assert_redirected_to effect_construction_effect_path(assigns(:effect_construction_effect))
  end

  test "should show effect_construction_effect" do
    get :show, id: @effect_construction_effect.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @effect_construction_effect.to_param
    assert_response :success
  end

  test "should update effect_construction_effect" do
    put :update, id: @effect_construction_effect.to_param, effect_construction_effect: @effect_construction_effect.attributes
    assert_redirected_to effect_construction_effect_path(assigns(:effect_construction_effect))
  end

  test "should destroy effect_construction_effect" do
    assert_difference('Effect::ConstructionEffect.count', -1) do
      delete :destroy, id: @effect_construction_effect.to_param
    end

    assert_redirected_to effect_construction_effects_path
  end
end
