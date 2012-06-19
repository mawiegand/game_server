class RemoveSpeedFromTrainingQueue < ActiveRecord::Migration
  def up
    remove_column :training_queues, :speed
  end

  def down
    add_column :training_queues, :speed, :integer
  end
end
