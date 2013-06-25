require 'test_helper'

class Shop::SpecialOffersControllerTest < ActionController::TestCase
  setup do
    @shop_special_offer = shop_special_offers(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_special_offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_special_offer" do
    assert_difference('Shop::SpecialOffer.count') do
      post :create, shop_special_offer: @shop_special_offer.attributes
    end

    assert_redirected_to shop_special_offer_path(assigns(:shop_special_offer))
  end

  test "should show shop_special_offer" do
    get :show, id: @shop_special_offer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_special_offer.to_param
    assert_response :success
  end

  test "should update shop_special_offer" do
    put :update, id: @shop_special_offer.to_param, shop_special_offer: @shop_special_offer.attributes
    assert_redirected_to shop_special_offer_path(assigns(:shop_special_offer))
  end

  test "should destroy shop_special_offer" do
    assert_difference('Shop::SpecialOffer.count', -1) do
      delete :destroy, id: @shop_special_offer.to_param
    end

    assert_redirected_to shop_special_offers_path
  end
end
