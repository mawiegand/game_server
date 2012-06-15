class CreateTrainingJobs < ActiveRecord::Migration
  def change
    create_table :training_jobs do |t|
      t.integer :queue_id
      t.integer :unit_id
      t.integer :position
      t.integer :quantity

      t.timestamps
    end
  end
end
