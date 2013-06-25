class CreateEffectConstructionEffects < ActiveRecord::Migration
  def change
    create_table :effect_construction_effects do |t|
      t.datetime :finished_at
      t.integer :type_id
      t.decimal :bonus
      t.integer :character_id
      t.integer :origin_id

      t.timestamps
    end
  end
end
