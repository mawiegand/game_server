class AddAdditionalMembersToFundamentalAlliance < ActiveRecord::Migration
  def change
    add_column :fundamental_alliances, :additional_members, :integer, :default => 0
  end
end
