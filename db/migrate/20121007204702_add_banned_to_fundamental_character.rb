class AddBannedToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :banned, :boolean
    add_column :fundamental_characters, :ban_reason, :string
    add_column :fundamental_characters, :ban_ended_at, :datetime
  end
end
