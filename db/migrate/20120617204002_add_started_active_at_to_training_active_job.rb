class AddStartedActiveAtToTrainingActiveJob < ActiveRecord::Migration
  def change
    add_column :training_active_jobs, :started_active_at, :datetime
  end
end
