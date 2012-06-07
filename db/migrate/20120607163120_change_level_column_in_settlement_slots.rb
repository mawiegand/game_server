class ChangeLevelColumnInSettlementSlots < ActiveRecord::Migration
  def up
    change_column  :settlement_slots, :level, :integer, :default => 0
  end
  
  def down
    change_column  :settlement_slots, :level, :integer
  end
end
