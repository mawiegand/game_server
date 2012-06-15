class ChangeSpeedColumnInTrainingQueue < ActiveRecord::Migration
  def up
    change_column  :training_queues, :speed, :integer, :default => 0.0   
  end

  def down
    change_column  :training_queues, :speed, :integer     
  end
end
