class AddSenderReceiverToLikeSystemLike < ActiveRecord::Migration
  def change
    add_column :like_system_likes, :sender_id, :integer, :default => 0
    add_column :like_system_likes, :receiver_id, :integer, :default => 0
  end
end
