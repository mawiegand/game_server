class AddConstructionBonusEffectToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :construction_bonus_effect, :decimal, :default => 0, :null => false
    add_column :fundamental_characters, :construction_bonus_total,  :decimal, :default => 0, :null => false
  end
end
