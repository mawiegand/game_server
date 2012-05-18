class CreateSettlementSlots < ActiveRecord::Migration
  def change
    create_table :settlement_slots do |t|
      t.integer :settlement_id
      t.integer :slot_num
      t.string :type
      t.integer :max_level
      t.integer :building_id
      t.integer :level
      t.integer :construction_id

      t.timestamps
    end
  end
end
