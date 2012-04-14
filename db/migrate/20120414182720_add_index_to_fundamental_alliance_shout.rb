class AddIndexToFundamentalAllianceShout < ActiveRecord::Migration
  def change
    add_index :fundamental_alliance_shouts, :created_at
  end
end
