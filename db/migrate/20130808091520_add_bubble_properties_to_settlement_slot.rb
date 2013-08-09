class AddBubblePropertiesToSettlementSlot < ActiveRecord::Migration
  def change
    add_column :settlement_slots, :bubble_resource_id,  :integer
    add_column :settlement_slots, :bubble_amount,       :integer
    add_column :settlement_slots, :bubble_xp,           :integer
    add_column :settlement_slots, :bubble_next_test_at, :datetime
  end
end
