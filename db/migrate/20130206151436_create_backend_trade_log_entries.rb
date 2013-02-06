class CreateBackendTradeLogEntries < ActiveRecord::Migration
  def change
    create_table :backend_trade_log_entries do |t|
      
      t.integer  :sender_id,           :null => false
      t.string   :sender_name,         :null => false
      t.integer  :sender_alliance_id   
      t.string   :sender_alliance_name
      t.integer  :recipient_id,        :null => false
      t.string   :recipient_name,      :null => false
      t.integer  :recipient_alliance_id
      t.string   :recipient_alliance_name
      t.datetime :target_reached_at
      t.integer  :num_carts,           :default => 0, :null => false
      t.integer  :event_id
      t.string   :sender_ip

      t.timestamps
    end
  end
end
