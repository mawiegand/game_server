require 'test_helper'

class Shop::OffersControllerTest < ActionController::TestCase
  setup do
    @shop_offer = shop_offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_offer" do
    assert_difference('Shop::Offer.count') do
      post :create, shop_offer: @shop_offer.attributes
    end

    assert_redirected_to shop_offer_path(assigns(:shop_offer))
  end

  test "should show shop_offer" do
    get :show, id: @shop_offer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_offer.to_param
    assert_response :success
  end

  test "should update shop_offer" do
    put :update, id: @shop_offer.to_param, shop_offer: @shop_offer.attributes
    assert_redirected_to shop_offer_path(assigns(:shop_offer))
  end

  test "should destroy shop_offer" do
    assert_difference('Shop::Offer.count', -1) do
      delete :destroy, id: @shop_offer.to_param
    end

    assert_redirected_to shop_offers_path
  end
end
