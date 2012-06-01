class AddSpeedupColumnsToContstructionQueue < ActiveRecord::Migration
  
  def change
    add_column :construction_queues, :speedup_buildings, :decimal, { :default => 0.0 }
    add_column :construction_queues, :speedup_sciences, :decimal, { :default => 0.0 }
    add_column :construction_queues, :speedup_alliance, :decimal, { :default => 0.0 }
    add_column :construction_queues, :speedup_effects, :decimal, { :default => 0.0 }
  end
  
end
