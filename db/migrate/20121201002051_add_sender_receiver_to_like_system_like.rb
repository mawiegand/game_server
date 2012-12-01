class AddSenderReceiverToLikeSystemLike < ActiveRecord::Migration
  def change
    add_column :like_system_likes, :sender_id, :id
    add_column :like_system_likes, :receiver_id, :id
  end
end
