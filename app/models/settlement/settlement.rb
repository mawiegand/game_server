class Settlement::Settlement < ActiveRecord::Base

  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id"
  
  has_many :slots, :class_name => "Settlement::Slot", :foreign_key => "settlement_id"

end
