require 'test_helper'

class Shop::FbMoneyTransactionsControllerTest < ActionController::TestCase
  setup do
    @shop_fb_money_transaction = shop_fb_money_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_fb_money_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_fb_money_transaction" do
    assert_difference('Shop::FbMoneyTransaction.count') do
      post :create, shop_fb_money_transaction: @shop_fb_money_transaction.attributes
    end

    assert_redirected_to shop_fb_money_transaction_path(assigns(:shop_fb_money_transaction))
  end

  test "should show shop_fb_money_transaction" do
    get :show, id: @shop_fb_money_transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_fb_money_transaction.to_param
    assert_response :success
  end

  test "should update shop_fb_money_transaction" do
    put :update, id: @shop_fb_money_transaction.to_param, shop_fb_money_transaction: @shop_fb_money_transaction.attributes
    assert_redirected_to shop_fb_money_transaction_path(assigns(:shop_fb_money_transaction))
  end

  test "should destroy shop_fb_money_transaction" do
    assert_difference('Shop::FbMoneyTransaction.count', -1) do
      delete :destroy, id: @shop_fb_money_transaction.to_param
    end

    assert_redirected_to shop_fb_money_transactions_path
  end
end
