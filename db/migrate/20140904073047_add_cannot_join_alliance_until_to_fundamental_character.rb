class AddCannotJoinAllianceUntilToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :cannot_join_alliance_until, :datetime
  end
end
