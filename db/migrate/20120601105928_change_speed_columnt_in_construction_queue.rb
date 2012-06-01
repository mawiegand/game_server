class ChangeSpeedColumntInConstructionQueue < ActiveRecord::Migration
  def up
    change_column  :construction_queues, :speed, :decimal, { :default => 0.0 }
  end
  
  def down
    change_column  :construction_queues, :speed, :float
  end
end
