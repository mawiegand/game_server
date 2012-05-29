class Settlement::Slot < ActiveRecord::Base

  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id",  :inverse_of => :slots
  
  has_many   :jobs,        :class_name => "Contstruction::Job",      :foreign_key => "slot_id",        :inverse_of => :slot

end
