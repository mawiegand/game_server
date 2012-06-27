require 'test_helper'

class Shop::ResourceOffersControllerTest < ActionController::TestCase
  setup do
    @shop_resource_offer = shop_resource_offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_resource_offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_resource_offer" do
    assert_difference('Shop::ResourceOffer.count') do
      post :create, shop_resource_offer: @shop_resource_offer.attributes
    end

    assert_redirected_to shop_resource_offer_path(assigns(:shop_resource_offer))
  end

  test "should show shop_resource_offer" do
    get :show, id: @shop_resource_offer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_resource_offer.to_param
    assert_response :success
  end

  test "should update shop_resource_offer" do
    put :update, id: @shop_resource_offer.to_param, shop_resource_offer: @shop_resource_offer.attributes
    assert_redirected_to shop_resource_offer_path(assigns(:shop_resource_offer))
  end

  test "should destroy shop_resource_offer" do
    assert_difference('Shop::ResourceOffer.count', -1) do
      delete :destroy, id: @shop_resource_offer.to_param
    end

    assert_redirected_to shop_resource_offers_path
  end
end
