class ChangeSpeedupColumnsInTrainingQueue < ActiveRecord::Migration
  def up
    change_column  :training_queues, :speedup_buildings, :integer, :default => 0.0       
    change_column  :training_queues, :speedup_sciences, :integer, :default => 0.0       
    change_column  :training_queues, :speedup_alliance, :integer, :default => 0.0       
    change_column  :training_queues, :speedup_effects, :integer, :default => 0.0       
  end

  def down
    change_column  :training_queues, :speedup_buildings, :integer
    change_column  :training_queues, :speedup_sciences, :integer       
    change_column  :training_queues, :speedup_alliance, :integer       
    change_column  :training_queues, :speedup_effects, :integer       
  end
end
