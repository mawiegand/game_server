class Settlement::Settlement < ActiveRecord::Base

  belongs_to :owner,    :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  belongs_to :founder,  :class_name => "Fundamental::Character", :foreign_key => "founder_id"  
  belongs_to :alliance, :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"  
  belongs_to :location, :class_name => "Map::Location",          :foreign_key => "location_id",   :inverse_of => :settlement  
  belongs_to :region,   :class_name => "Map::Region",            :foreign_key => "region_id",     :inverse_of => :settlements 
  
  has_many   :slots,    :class_name => "Settlement::Slot",       :foreign_key => "settlement_id", :inverse_of => :settlement
  
  after_initialize :init
  
  after_save :propagate_information_to_region
  after_save :propagate_information_to_location

  def owns_region?
    owns_region == true
  end
  
  # set default values in an after_initialize handler. 
  def init
    level         ||= 1
    defense_bonus = 0     if defense_bonus.nil?
    morale        = 1.0   if morale.nil?
    tax_rate      = 0.1   if tax_rate.nil? && owns_region
    taxable       = !owns_region
    command_points= 0     if command_points.nil?
    besieged      = false if besieged.nil?
    points        = 0     if points.nil?
  end
  
  def create_building_slots_according_to(spec)
    spec.each do |number, details|
      self.slots.create({
        :slot_num => number,
        :building_id => nil,
        :level => 0, 
      })
    end
  end
  
  def propagate_information_to_location
    if !self.location.nil?
      self.location.set_owner_and_alliance(owner_id, alliance_id)
      self.location.settlement_level   = self.level   if (self.location.settlement_level   != self.level)
      self.location.settlement_type_id = self.type_id if (self.location.settlement_type_id != self.type_id)
      self.location.save
    end
    return true
  end
  
  def propagate_information_to_region
    if self.owns_region? && !self.region.nil?
      self.region.set_owner_and_alliance(owner_id, alliance_id)
      self.region.settlement_level   = self.level     if (self.region.settlement_level   != self.level)
      self.region.settlement_type_id = self.type_id   if (self.region.settlement_type_id != self.type_id) 
      self.region.save
    end
    return true
  end
  
    

end
