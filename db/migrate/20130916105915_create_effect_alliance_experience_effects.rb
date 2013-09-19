class CreateEffectAllianceExperienceEffects < ActiveRecord::Migration
  def change
    create_table :effect_alliance_experience_effects do |t|
      t.integer :type_id
      t.integer :origin_id
      t.integer :alliance_id
      t.decimal :bonus

      t.timestamps
    end
  end
end
