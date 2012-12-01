class AddSenderReceiverToLikeSystemDislike < ActiveRecord::Migration
  def change
    add_column :like_system_dislikes, :sender_id, :integer, :default => 0
    add_column :like_system_dislikes, :receiver_id, :integer, :default => 0
  end
end
