class CreateActionMilitaryMoveArmyActions < ActiveRecord::Migration
  def change
    create_table :action_military_move_army_actions do |t|
      t.integer :army_id
      t.integer :starting_location_id
      t.integer :starting_region_id
      t.integer :target_location_id
      t.integer :target_region_id
      t.string :sender_ip

      t.timestamps
    end
  end
end
