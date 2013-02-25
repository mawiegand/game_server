require 'test_helper'

class Effect::AllianceResourceEffectsControllerTest < ActionController::TestCase
  setup do
    @effect_alliance_resource_effect = effect_alliance_resource_effects(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:effect_alliance_resource_effects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create effect_alliance_resource_effect" do
    assert_difference('Effect::AllianceResourceEffect.count') do
      post :create, effect_alliance_resource_effect: @effect_alliance_resource_effect.attributes
    end

    assert_redirected_to effect_alliance_resource_effect_path(assigns(:effect_alliance_resource_effect))
  end

  test "should show effect_alliance_resource_effect" do
    get :show, id: @effect_alliance_resource_effect.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @effect_alliance_resource_effect.to_param
    assert_response :success
  end

  test "should update effect_alliance_resource_effect" do
    put :update, id: @effect_alliance_resource_effect.to_param, effect_alliance_resource_effect: @effect_alliance_resource_effect.attributes
    assert_redirected_to effect_alliance_resource_effect_path(assigns(:effect_alliance_resource_effect))
  end

  test "should destroy effect_alliance_resource_effect" do
    assert_difference('Effect::AllianceResourceEffect.count', -1) do
      delete :destroy, id: @effect_alliance_resource_effect.to_param
    end

    assert_redirected_to effect_alliance_resource_effects_path
  end
end
