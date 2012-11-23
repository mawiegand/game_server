class LikeSystem::Dislike < ActiveRecord::Base
  belongs_to :sender, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :send_dislikes, :counter_cache => true
  belongs_to :receiver, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :received_dislikes, :counter_cache => true
end
