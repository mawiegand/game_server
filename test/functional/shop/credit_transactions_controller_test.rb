require 'test_helper'

class Shop::CreditTransactionsControllerTest < ActionController::TestCase
  setup do
    @shop_credit_transaction = shop_credit_transactions(:one)
    @controller.current_backend_user = backend_users(:staff)  # this is a quick hack to make the scaffolded tests pass. Must be moved to individual tests later.    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_credit_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_credit_transaction" do
    assert_difference('Shop::CreditTransaction.count') do
      post :create, shop_credit_transaction: @shop_credit_transaction.attributes
    end

    assert_redirected_to shop_credit_transaction_path(assigns(:shop_credit_transaction))
  end

  test "should show shop_credit_transaction" do
    get :show, id: @shop_credit_transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_credit_transaction.to_param
    assert_response :success
  end

  test "should update shop_credit_transaction" do
    put :update, id: @shop_credit_transaction.to_param, shop_credit_transaction: @shop_credit_transaction.attributes
    assert_redirected_to shop_credit_transaction_path(assigns(:shop_credit_transaction))
  end

  test "should destroy shop_credit_transaction" do
    assert_difference('Shop::CreditTransaction.count', -1) do
      delete :destroy, id: @shop_credit_transaction.to_param
    end

    assert_redirected_to shop_credit_transactions_path
  end
end
