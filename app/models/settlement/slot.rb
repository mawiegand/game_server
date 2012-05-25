class Settlement::Slot < ActiveRecord::Base

  belongs_to :settlement, :class_name => "Settlement::Settlement", :foreign_key => "settlement_id", :inverse_of => :slots

end
