class RemoveQuantityFinishedFromTrainingActiveJob < ActiveRecord::Migration
  def up
    remove_column :training_active_jobs, :quantity_finished
  end

  def down
    add_column :training_active_jobs, :quantity_finished, :integer
  end
end
