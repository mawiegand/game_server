class AddConstructionBonusEffectsToFundamentalAlliance < ActiveRecord::Migration
  def change
    add_column :fundamental_alliances, :construction_bonus_effects, :decimal, :default => 0.0,   :null => false
  end
end
