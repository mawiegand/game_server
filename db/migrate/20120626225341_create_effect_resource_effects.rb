class CreateEffectResourceEffects < ActiveRecord::Migration
  def change
    create_table :effect_resource_effects do |t|
      t.decimal :speedup
      t.integer :resource_id
      t.datetime :finished_at

      t.timestamps
    end
  end
end
