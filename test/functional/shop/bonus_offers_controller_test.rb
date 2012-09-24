require 'test_helper'

class Shop::BonusOffersControllerTest < ActionController::TestCase
  setup do
    @shop_bonus_offer = shop_bonus_offers(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_bonus_offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_bonus_offer" do
    assert_difference('Shop::BonusOffer.count') do
      post :create, shop_bonus_offer: @shop_bonus_offer.attributes
    end

    assert_redirected_to shop_bonus_offer_path(assigns(:shop_bonus_offer))
  end

  test "should show shop_bonus_offer" do
    get :show, id: @shop_bonus_offer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_bonus_offer.to_param
    assert_response :success
  end

  test "should update shop_bonus_offer" do
    put :update, id: @shop_bonus_offer.to_param, shop_bonus_offer: @shop_bonus_offer.attributes
    assert_redirected_to shop_bonus_offer_path(assigns(:shop_bonus_offer))
  end

  test "should destroy shop_bonus_offer" do
    assert_difference('Shop::BonusOffer.count', -1) do
      delete :destroy, id: @shop_bonus_offer.to_param
    end

    assert_redirected_to shop_bonus_offers_path
  end
end
