class AddCharacterIdToEffectResourceEffect < ActiveRecord::Migration
  def change
    add_column :effect_resource_effects, :character_id, :integer
  end
end
