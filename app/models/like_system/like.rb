class LikeSystem::Like < ActiveRecord::Base
  belongs_to :sender, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :send_likes, :counter_cache => true
  belongs_to :receiver, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :received_likes, :counter_cache => true
end
