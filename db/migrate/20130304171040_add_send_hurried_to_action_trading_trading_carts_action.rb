class AddSendHurriedToActionTradingTradingCartsAction < ActiveRecord::Migration
  def change
    add_column :action_trading_trading_carts_actions, :send_hurried, :boolean
    add_column :action_trading_trading_carts_actions, :return_hurried, :boolean
  end
end
