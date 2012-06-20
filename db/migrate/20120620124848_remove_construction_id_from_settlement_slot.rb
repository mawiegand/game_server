#removes two obsolete columns from slots
class RemoveConstructionIdFromSettlementSlot < ActiveRecord::Migration
  def up
    remove_column :settlement_slots, :construction_id            # has never been used, we have queues and jobs for that
    remove_column :settlement_slots, :max_level                  # is in the rules, thus, does not need to be stored in the model
  end

  def down
    add_column    :settlement_slots, :construction_id, :integer
    add_column    :settlement_slots, :max_level, :integer
  end
end
