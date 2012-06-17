class RemoveProgressUpdatedAtFromTrainingActiveJob < ActiveRecord::Migration
  def up
    remove_column :training_active_jobs, :progress_updated_at
  end

  def down
    add_column :training_active_jobs, :progress_updated_at, :datetime
  end
end
