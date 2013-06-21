require 'test_helper'

class Shop::SpecialOffersTransactionsControllerTest < ActionController::TestCase
  setup do
    @shop_special_offers_transaction = shop_special_offers_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_special_offers_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_special_offers_transaction" do
    assert_difference('Shop::SpecialOffersTransaction.count') do
      post :create, shop_special_offers_transaction: @shop_special_offers_transaction.attributes
    end

    assert_redirected_to shop_special_offers_transaction_path(assigns(:shop_special_offers_transaction))
  end

  test "should show shop_special_offers_transaction" do
    get :show, id: @shop_special_offers_transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_special_offers_transaction.to_param
    assert_response :success
  end

  test "should update shop_special_offers_transaction" do
    put :update, id: @shop_special_offers_transaction.to_param, shop_special_offers_transaction: @shop_special_offers_transaction.attributes
    assert_redirected_to shop_special_offers_transaction_path(assigns(:shop_special_offers_transaction))
  end

  test "should destroy shop_special_offers_transaction" do
    assert_difference('Shop::SpecialOffersTransaction.count', -1) do
      delete :destroy, id: @shop_special_offers_transaction.to_param
    end

    assert_redirected_to shop_special_offers_transactions_path
  end
end
