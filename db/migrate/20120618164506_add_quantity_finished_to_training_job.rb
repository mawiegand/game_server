class AddQuantityFinishedToTrainingJob < ActiveRecord::Migration
  def change
    add_column :training_jobs, :quantity_finished, :integer
  end
end
