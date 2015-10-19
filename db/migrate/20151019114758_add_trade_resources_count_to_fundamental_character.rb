class AddTradeResourcesCountToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :trade_resources_count, :integer, default: 0, null: false
  end
end
