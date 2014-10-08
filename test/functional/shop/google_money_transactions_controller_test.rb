require 'test_helper'

class Shop::GoogleMoneyTransactionsControllerTest < ActionController::TestCase
  setup do
    @shop_google_money_transaction = shop_google_money_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_google_money_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_google_money_transaction" do
    assert_difference('Shop::GoogleMoneyTransaction.count') do
      post :create, shop_google_money_transaction: @shop_google_money_transaction.attributes
    end

    assert_redirected_to shop_google_money_transaction_path(assigns(:shop_google_money_transaction))
  end

  test "should show shop_google_money_transaction" do
    get :show, id: @shop_google_money_transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_google_money_transaction.to_param
    assert_response :success
  end

  test "should update shop_google_money_transaction" do
    put :update, id: @shop_google_money_transaction.to_param, shop_google_money_transaction: @shop_google_money_transaction.attributes
    assert_redirected_to shop_google_money_transaction_path(assigns(:shop_google_money_transaction))
  end

  test "should destroy shop_google_money_transaction" do
    assert_difference('Shop::GoogleMoneyTransaction.count', -1) do
      delete :destroy, id: @shop_google_money_transaction.to_param
    end

    assert_redirected_to shop_google_money_transactions_path
  end
end
