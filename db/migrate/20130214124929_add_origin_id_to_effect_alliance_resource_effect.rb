class AddOriginIdToEffectAllianceResourceEffect < ActiveRecord::Migration
  def change
    add_column :effect_alliance_resource_effects, :origin_id, :integer
  end
end
