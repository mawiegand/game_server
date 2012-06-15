class CreateTrainingActiveJobs < ActiveRecord::Migration
  def change
    create_table :training_active_jobs do |t|
      t.integer :queue_id
      t.integer :job_id
      t.datetime :started_total_at
      t.datetime :finsished_total_at
      t.float :progress_total
      t.datetime :progress_updated_at
      t.integer :quantity_finished
      t.integer :quantity_active
      t.datetime :started_finished_at
      t.datetime :finished_active_at
      t.float :progress_active
      t.datetime :progress_active_updated_at

      t.timestamps
    end
  end
end
