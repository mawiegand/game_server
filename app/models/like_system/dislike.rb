class LikeSystem::Dislike < ActiveRecord::Base
  belongs_to :sender, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :send_dislikes, :counter_cache => :send_dislikes_count
  belongs_to :receiver, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :received_dislikes, :counter_cache => :received_dislikes_count
end
