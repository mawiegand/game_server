require 'test_helper'

class Effect::AllianceExperienceEffectsControllerTest < ActionController::TestCase
  setup do
    @effect_alliance_experience_effect = effect_alliance_experience_effects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:effect_alliance_experience_effects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create effect_alliance_experience_effect" do
    assert_difference('Effect::AllianceExperienceEffect.count') do
      post :create, effect_alliance_experience_effect: @effect_alliance_experience_effect.attributes
    end

    assert_redirected_to effect_alliance_experience_effect_path(assigns(:effect_alliance_experience_effect))
  end

  test "should show effect_alliance_experience_effect" do
    get :show, id: @effect_alliance_experience_effect.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @effect_alliance_experience_effect.to_param
    assert_response :success
  end

  test "should update effect_alliance_experience_effect" do
    put :update, id: @effect_alliance_experience_effect.to_param, effect_alliance_experience_effect: @effect_alliance_experience_effect.attributes
    assert_redirected_to effect_alliance_experience_effect_path(assigns(:effect_alliance_experience_effect))
  end

  test "should destroy effect_alliance_experience_effect" do
    assert_difference('Effect::AllianceExperienceEffect.count', -1) do
      delete :destroy, id: @effect_alliance_experience_effect.to_param
    end

    assert_redirected_to effect_alliance_experience_effects_path
  end
end
