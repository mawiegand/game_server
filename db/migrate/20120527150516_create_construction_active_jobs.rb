class CreateConstructionActiveJobs < ActiveRecord::Migration
  def change
    create_table :construction_active_jobs do |t|
      t.integer :queue_id
      t.integer :job_id
      t.timestamp :started_at
      t.timestamp :finished_at
      t.float :progress, :default => 0

      t.timestamps
    end
  end
end
