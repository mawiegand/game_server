class Military::ArmyDetail < ActiveRecord::Base

  belongs_to :army, :class_name => "Military::Army", :foreign_key => "army_id"    

end
