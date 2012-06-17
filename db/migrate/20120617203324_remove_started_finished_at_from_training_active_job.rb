class RemoveStartedFinishedAtFromTrainingActiveJob < ActiveRecord::Migration
  def up
    remove_column :training_active_jobs, :started_finished_at
  end

  def down
    add_column :training_active_jobs, :started_finished_at, :datetime
  end
end
