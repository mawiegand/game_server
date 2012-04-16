class AddColumnToEventEvents < ActiveRecord::Migration
  def change
    add_column :event_events, :local_event_id, :integer
  end
end
