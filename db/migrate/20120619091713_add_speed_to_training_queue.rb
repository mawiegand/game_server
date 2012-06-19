class AddSpeedToTrainingQueue < ActiveRecord::Migration
  def change
    add_column :training_queues, :speed, :decimal, :default => 0.0
  end
end
