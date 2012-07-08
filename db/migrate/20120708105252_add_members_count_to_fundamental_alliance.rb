class AddMembersCountToFundamentalAlliance < ActiveRecord::Migration
  def change
    add_column :fundamental_alliances, :members_count, :integer
  end
end
