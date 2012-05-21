class CreateSettlementSettlements < ActiveRecord::Migration
  def change
    create_table :settlement_settlements do |t|
      t.integer :type_id
      t.integer :region_id
      t.integer :location_id
      t.integer :node_id
      t.integer :owner_id
      t.integer :alliance_id
      t.integer :level
      t.datetime :founded_at
      t.datetime :founder_id
      t.decimal :defense_bonus
      t.decimal :morale
      t.decimal :tax_rate
      t.boolean :owns_region
      t.boolean :taxable
      t.integer :command_points
      t.integer :armies_count
      t.integer :garrison_id
      t.boolean :besieged

      t.timestamps
    end
  end
end
