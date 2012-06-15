class CreateTrainingQueues < ActiveRecord::Migration
  def change
    create_table :training_queues do |t|
      t.integer :settlement_id
      t.integer :type_id
      t.decimal :speed
      t.integer :max_length
      t.integer :threads
      t.integer :jobs_count
      t.decimal :speedup_buildings
      t.decimal :speedup_sciences
      t.decimal :speedup_alliance
      t.decimal :speedup_effects

      t.timestamps
    end
  end
end
