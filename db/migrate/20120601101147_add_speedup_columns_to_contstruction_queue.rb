class AddSpeedupColumnsToContstructionQueue < ActiveRecord::Migration
  def change
    add_column :construction_queues, :speedup_buildings, :decimal
    add_column :construction_queues, :speedup_sciences, :decimal
    add_column :construction_queues, :speedup_alliance, :decimal
    add_column :construction_queues, :speedup_effects, :decimal
    change_column  :construction_queues, :speed, :decimal
  end
end
