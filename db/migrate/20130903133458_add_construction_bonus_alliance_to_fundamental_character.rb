class AddConstructionBonusAllianceToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :construction_bonus_alliance, :decimal, :default => 0.0,   :null => false
  end
end
