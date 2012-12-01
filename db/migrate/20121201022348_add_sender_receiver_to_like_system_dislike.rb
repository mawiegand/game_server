class AddSenderReceiverToLikeSystemDislike < ActiveRecord::Migration
  def change
    add_column :like_system_dislikes, :sender_id, :id
    add_column :like_system_dislikes, :receiver_id, :id
  end
end
