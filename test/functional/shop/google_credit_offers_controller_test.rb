require 'test_helper'

class Shop::GoogleCreditOffersControllerTest < ActionController::TestCase
  setup do
    @shop_google_credit_offer = shop_google_credit_offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_google_credit_offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_google_credit_offer" do
    assert_difference('Shop::GoogleCreditOffer.count') do
      post :create, shop_google_credit_offer: @shop_google_credit_offer.attributes
    end

    assert_redirected_to shop_google_credit_offer_path(assigns(:shop_google_credit_offer))
  end

  test "should show shop_google_credit_offer" do
    get :show, id: @shop_google_credit_offer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_google_credit_offer.to_param
    assert_response :success
  end

  test "should update shop_google_credit_offer" do
    put :update, id: @shop_google_credit_offer.to_param, shop_google_credit_offer: @shop_google_credit_offer.attributes
    assert_redirected_to shop_google_credit_offer_path(assigns(:shop_google_credit_offer))
  end

  test "should destroy shop_google_credit_offer" do
    assert_difference('Shop::GoogleCreditOffer.count', -1) do
      delete :destroy, id: @shop_google_credit_offer.to_param
    end

    assert_redirected_to shop_google_credit_offers_path
  end
end
