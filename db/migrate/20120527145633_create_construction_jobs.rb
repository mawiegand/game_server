class CreateConstructionJobs < ActiveRecord::Migration
  def change
    create_table :construction_jobs do |t|
      t.integer :queue_id
      t.integer :slot_id
      t.integer :building_type_id
      t.integer :position
      t.integer :level_before
      t.integer :level_after
      t.string :job_type

      t.timestamps
    end
  end
end
