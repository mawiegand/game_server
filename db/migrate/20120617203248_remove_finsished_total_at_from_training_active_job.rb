class RemoveFinsishedTotalAtFromTrainingActiveJob < ActiveRecord::Migration
  def up
    remove_column :training_active_jobs, :finsished_total_at
  end

  def down
    add_column :training_active_jobs, :finsished_total_at, :datetime
  end
end
