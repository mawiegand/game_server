class RemoveCharacterIdFromEffectResourceEffect < ActiveRecord::Migration
  def up
    remove_column :effect_resource_effects, :character_id
  end

  def down
    add_column :effect_resource_effects, :character_id, :integer
  end
end
