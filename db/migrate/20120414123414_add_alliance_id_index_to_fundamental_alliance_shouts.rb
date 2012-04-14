class AddAllianceIdIndexToFundamentalAllianceShouts < ActiveRecord::Migration
  def change
    add_index :fundamental_alliance_shouts, :alliance_id
    add_index :fundamental_alliance_shouts, :character_id
  end
end
