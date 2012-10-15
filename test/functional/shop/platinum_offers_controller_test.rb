require 'test_helper'

class Shop::PlatinumOffersControllerTest < ActionController::TestCase
  setup do
    @shop_platinum_offer = shop_platinum_offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_platinum_offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_platinum_offer" do
    assert_difference('Shop::PlatinumOffer.count') do
      post :create, shop_platinum_offer: @shop_platinum_offer.attributes
    end

    assert_redirected_to shop_platinum_offer_path(assigns(:shop_platinum_offer))
  end

  test "should show shop_platinum_offer" do
    get :show, id: @shop_platinum_offer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_platinum_offer.to_param
    assert_response :success
  end

  test "should update shop_platinum_offer" do
    put :update, id: @shop_platinum_offer.to_param, shop_platinum_offer: @shop_platinum_offer.attributes
    assert_redirected_to shop_platinum_offer_path(assigns(:shop_platinum_offer))
  end

  test "should destroy shop_platinum_offer" do
    assert_difference('Shop::PlatinumOffer.count', -1) do
      delete :destroy, id: @shop_platinum_offer.to_param
    end

    assert_redirected_to shop_platinum_offers_path
  end
end
