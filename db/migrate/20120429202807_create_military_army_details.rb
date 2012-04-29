class CreateMilitaryArmyDetails < ActiveRecord::Migration
  def change
    create_table :military_army_details do |t|
      t.integer :army_id

      t.timestamps
    end
  end
end
