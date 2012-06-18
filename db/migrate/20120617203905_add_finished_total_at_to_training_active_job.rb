class AddFinishedTotalAtToTrainingActiveJob < ActiveRecord::Migration
  def change
    add_column :training_active_jobs, :finished_total_at, :datetime
  end
end
