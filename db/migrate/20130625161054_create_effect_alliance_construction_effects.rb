class CreateEffectAllianceConstructionEffects < ActiveRecord::Migration
  def change
    create_table :effect_alliance_construction_effects do |t|
      t.datetime :finished_at
      t.integer :type_id
      t.decimal :bonus
      t.integer :alliance_id
      t.integer :origin_id

      t.timestamps
    end
  end
end
