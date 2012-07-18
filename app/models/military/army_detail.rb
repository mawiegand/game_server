class Military::ArmyDetail < ActiveRecord::Base

  belongs_to :army, :class_name => "Military::Army", :foreign_key => "army_id", :touch => true, :inverse_of => :details

  after_save :update_army

  private
  
    def update_army
      self.army.update_from_details
    end

end
