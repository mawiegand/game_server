class Settlement::Settlement < ActiveRecord::Base

  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  belongs_to :location, :class_name => "Map::Location", :foreign_key => "location_id", :inverse_of => :settlement  
  
  has_many :slots, :class_name => "Settlement::Slot", :foreign_key => "settlement_id", :inverse_of => :settlement
  
  def create_building_slots_according_to(spec)
    
    spec.each do |number, details|
      self.slots.create({
        :slot_num => number,
        :building_id => nil,
        :level => 0, 
      })
    end
    
  end

end
