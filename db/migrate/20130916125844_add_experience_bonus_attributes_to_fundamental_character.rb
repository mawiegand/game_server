class AddExperienceBonusAttributesToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :exp_bonus_total, :decimal, :default => 0.0, :null => false
    add_column :fundamental_characters, :exp_bonus_effects, :decimal, :default => 0.0, :null => false
    add_column :fundamental_characters, :exp_bonus_alliance, :decimal, :default => 0.0, :null => false
  end
end
