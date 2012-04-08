class CreateEventsEvents < ActiveRecord::Migration
  def change
    create_table  :event_events do |t|
      t.integer   :character_id
      t.datetime  :execute_at
      t.string    :event_type
      t.datetime  :locked_at
      t.string    :locked_by
      t.integer   :error_code
      t.integer   :localized_error_description
      t.datetime  :finished_at
      t.boolean   :blocked
      t.string    :blocked_by
      t.string    :localized_blocked_reason
      t.timestamps
    end
  end
end
