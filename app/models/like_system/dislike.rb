class LikeSystem::Dislike < ActiveRecord::Base
  belongs_to :sender, :class_name => "Fundamental::Character", :foreign_key => "sender_id", :inverse_of => :send_dislikes, :counter_cache => :send_dislikes_count
  belongs_to :receiver, :class_name => "Fundamental::Character", :foreign_key => "receiver_id", :inverse_of => :received_dislikes, :counter_cache => :received_dislikes_count
  
  validates :sender, :presence => true
  validates :receiver, :presence => true
  
  before_save :validate_dislike
  after_save :pay_dislike
  
  def validate_dislike
    return false if self.sender == self.receiver || self.sender.resource_pool.dislike_amount < 1.0
  end
  
  def pay_like
    self.sender.resource_pool.decrement!(:dislike_amount)
  end
end
