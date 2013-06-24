require 'test_helper'

class Shop::PurchasesControllerTest < ActionController::TestCase
  setup do
    @shop_purchase = shop_purchases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_purchases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_purchase" do
    assert_difference('Shop::Purchase.count') do
      post :create, shop_purchase: @shop_purchase.attributes
    end

    assert_redirected_to shop_purchase_path(assigns(:shop_purchase))
  end

  test "should show shop_purchase" do
    get :show, id: @shop_purchase.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_purchase.to_param
    assert_response :success
  end

  test "should update shop_purchase" do
    put :update, id: @shop_purchase.to_param, shop_purchase: @shop_purchase.attributes
    assert_redirected_to shop_purchase_path(assigns(:shop_purchase))
  end

  test "should destroy shop_purchase" do
    assert_difference('Shop::Purchase.count', -1) do
      delete :destroy, id: @shop_purchase.to_param
    end

    assert_redirected_to shop_purchases_path
  end
end
