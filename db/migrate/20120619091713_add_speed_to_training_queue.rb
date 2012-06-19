class AddSpeedToTrainingQueue < ActiveRecord::Migration
  def change
    add_column :training_queues, :speed, :decimal, {:default => 1.0, :null => false}
  end
end
