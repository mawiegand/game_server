class AddProductionRatesToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :exp_production_rate, :decimal, :default => 0.0, :null => false
    add_column :fundamental_characters, :exp_building_production_rate, :decimal, :default => 0.0, :null => false
    add_column :fundamental_characters, :production_updated_at, :datetime
  end
end
