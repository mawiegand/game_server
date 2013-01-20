class AddAttributesToFundamentalHistoryEvent < ActiveRecord::Migration
  def change
    add_column :fundamental_history_events, :character_id, :integer
    add_column :fundamental_history_events, :data, :text
    add_column :fundamental_history_events, :localized_description, :text
  end
end
