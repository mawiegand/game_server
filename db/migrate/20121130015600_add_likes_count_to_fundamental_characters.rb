class AddLikesCountToFundamentalCharacters < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :likes_count, :integer, :default => 0
    add_column :fundamental_characters, :dislikes_count, :integer, :default => 0
  end
end
