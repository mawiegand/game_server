class CreateFundamentalHistoryEvents < ActiveRecord::Migration
  def change
    create_table :fundamental_history_events do |t|

      t.timestamps
    end
  end
end
