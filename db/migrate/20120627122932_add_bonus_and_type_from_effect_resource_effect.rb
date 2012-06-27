class AddBonusAndTypeFromEffectResourceEffect < ActiveRecord::Migration
  def change
    add_column :effect_resource_effects, :type_id, :integer
    add_column :effect_resource_effects, :bonus, :decimal
  end
end
