class AddProgressTotalUpdatedAtToTrainingActiveJob < ActiveRecord::Migration
  def change
    add_column :training_active_jobs, :progress_total_updated_at, :datetime
  end
end
