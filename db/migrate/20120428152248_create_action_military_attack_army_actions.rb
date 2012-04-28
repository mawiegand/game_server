class CreateActionMilitaryAttackArmyActions < ActiveRecord::Migration
  def change
    create_table :action_military_attack_army_actions do |t|
      t.integer :attacker_id
      t.integer :defender_id

      t.timestamps
    end
  end
end
