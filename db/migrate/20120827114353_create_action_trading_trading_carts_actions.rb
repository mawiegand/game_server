class CreateActionTradingTradingCartsActions < ActiveRecord::Migration
  def change
    create_table :action_trading_trading_carts_actions do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :starting_region_id
      t.integer :target_region_id
      t.boolean :returning
      t.datetime :target_reached_at
      t.datetime :returned_at
      t.integer :num_carts
      t.integer :event_id
      t.string :sender_ip
      t.integer :starting_settlement_id
      t.integer :target_settlement_id

      t.timestamps
    end
  end
end
