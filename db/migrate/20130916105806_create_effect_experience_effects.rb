class CreateEffectExperienceEffects < ActiveRecord::Migration
  def change
    create_table :effect_experience_effects do |t|
      t.integer :type_id
      t.integer :origin_id
      t.integer :character_id
      t.decimal :bonus
      t.datetime :finished_at

      t.timestamps
    end
  end
end
