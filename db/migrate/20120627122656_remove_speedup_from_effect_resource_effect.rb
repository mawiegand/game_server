class RemoveSpeedupFromEffectResourceEffect < ActiveRecord::Migration
  def up
    remove_column :effect_resource_effects, :speedup
  end

  def down
    add_column :effect_resource_effects, :speedup, :decimal
  end
end
