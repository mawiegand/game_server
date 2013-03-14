class CreateEffectAllianceResourceEffects < ActiveRecord::Migration
  def change
    create_table :effect_alliance_resource_effects do |t|
      t.integer :resource_id
      t.integer :type_id
      t.decimal :bonus
      t.integer :alliance_id

      t.timestamps
    end
  end
end
