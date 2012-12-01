class LikeSystem::Like < ActiveRecord::Base
  belongs_to :sender, :class_name => "Fundamental::Character", :foreign_key => "sender_id", :inverse_of => :send_likes, :counter_cache => :send_likes_count
  belongs_to :receiver, :class_name => "Fundamental::Character", :foreign_key => "receiver_id", :inverse_of => :received_likes, :counter_cache => :received_likes_count
end
