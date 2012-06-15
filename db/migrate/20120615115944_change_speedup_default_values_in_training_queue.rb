class ChangeSpeedupDefaultValuesInTrainingQueue < ActiveRecord::Migration
  def up
    change_column  :training_queues, :speedup_buildings, :decimal, {:default => 0.0, :null => false}       
    change_column  :training_queues, :speedup_sciences, :decimal, {:default => 0.0, :null => false}       
    change_column  :training_queues, :speedup_alliance, :decimal, {:default => 0.0, :null => false}       
    change_column  :training_queues, :speedup_effects, :decimal, {:default => 0.0, :null => false}       
  end

  def down
    change_column  :training_queues, :speedup_buildings, :integer, :default => 0.0       
    change_column  :training_queues, :speedup_sciences, :integer, :default => 0.0       
    change_column  :training_queues, :speedup_alliance, :integer, :default => 0.0       
    change_column  :training_queues, :speedup_effects, :integer, :default => 0.0       
  end
end
