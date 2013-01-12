class LikeSystem::Like < ActiveRecord::Base
  belongs_to :sender, :class_name => "Fundamental::Character", :foreign_key => "sender_id", :inverse_of => :send_likes
  belongs_to :receiver, :class_name => "Fundamental::Character", :foreign_key => "receiver_id", :inverse_of => :received_likes
  
  validates :sender,   :presence => true
  validates :receiver, :presence => true
  
  # before_save :validate_like
  after_save  :pay_like
  
  def validate_like
    self.sender != self.receiver && self.sender.resource_pool.like_amount >= 1.0
  end
  
  def pay_like
    self.sender.resource_pool.decrement!(:like_amount)
  end
end
