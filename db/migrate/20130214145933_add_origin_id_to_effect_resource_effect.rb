class AddOriginIdToEffectResourceEffect < ActiveRecord::Migration
  def change
    add_column :effect_resource_effects, :origin_id, :integer
  end
end
