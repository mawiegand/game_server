class RemoveLikesCountFromFundamentalCharacters < ActiveRecord::Migration
  def up
    remove_column :fundamental_characters, :dislikes_count
    add_column :fundamental_characters, :send_dislikes_count, :integer, :default => 0
    add_column :fundamental_characters, :received_dislikes_count, :integer, :default => 0
  end

  def down
    add_column :fundamental_characters, :dislikes_count, :integer
    remove_column :fundamental_characters, :send_dislikes_count
    remove_column :fundamental_characters, :received_dislikes_count
  end
end
