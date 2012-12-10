class RemoveLikesCountFromFundamentalCharacters < ActiveRecord::Migration
  def up
    remove_column :fundamental_characters, :likes_count
    add_column :fundamental_characters, :send_likes_count, :integer, :default => 0
    add_column :fundamental_characters, :received_likes_count, :integer, :default => 0
  end

  def down
    add_column :fundamental_characters, :likes_count, :integer
    remove_column :fundamental_characters, :send_likes_count
    remove_column :fundamental_characters, :received_likes_count
  end
end
