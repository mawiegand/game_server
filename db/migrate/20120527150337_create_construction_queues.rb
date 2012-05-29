class CreateConstructionQueues < ActiveRecord::Migration
  def change
    create_table :construction_queues do |t|
      t.integer :settlement_id
      t.integer :type_id
      t.float   :speed, :default => 1
      t.integer :max_length
      t.integer :threads
      t.integer :jobs_count

      t.timestamps
    end
  end
end
