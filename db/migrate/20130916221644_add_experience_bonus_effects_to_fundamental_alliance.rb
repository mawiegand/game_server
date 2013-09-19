class AddExperienceBonusEffectsToFundamentalAlliance < ActiveRecord::Migration
  def change
    add_column :fundamental_alliances, :experience_bonus_effects, :decimal, :default => 0.0, :null => false
  end
end
