class Settlement::Settlement < ActiveRecord::Base

  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id"  

end
