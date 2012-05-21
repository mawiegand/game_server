require 'test_helper'

class Shop::TransactionsControllerTest < ActionController::TestCase
  setup do
    @shop_transaction = shop_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_transaction" do
    assert_difference('Shop::Transaction.count') do
      post :create, shop_transaction: @shop_transaction.attributes
    end

    assert_redirected_to shop_transaction_path(assigns(:shop_transaction))
  end

  test "should show shop_transaction" do
    get :show, id: @shop_transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_transaction.to_param
    assert_response :success
  end

  test "should update shop_transaction" do
    put :update, id: @shop_transaction.to_param, shop_transaction: @shop_transaction.attributes
    assert_redirected_to shop_transaction_path(assigns(:shop_transaction))
  end

  test "should destroy shop_transaction" do
    assert_difference('Shop::Transaction.count', -1) do
      delete :destroy, id: @shop_transaction.to_param
    end

    assert_redirected_to shop_transactions_path
  end
end
