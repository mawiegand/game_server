class Map::Region < ActiveRecord::Base
  
  belongs_to :node, :class_name => "Node",                      :foreign_key => "node_id"
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  belongs_to :owner, :class_name => "Fundamental::Character",   :foreign_key => "owner_id"  
  has_many :locations, :class_name => "Location",               :foreign_key => "region_id", :order => :slot,          :dependent => :destroy
  has_one  :fortress_location, :class_name => "Location",       :foreign_key => "region_id", :conditions => 'slot = 0'
  has_many :armies, :class_name => "Military::Army",            :foreign_key => "region_id"
  
  has_many :battles, :class_name => "Military::Battle", :inverse_of => :region
  
  def recount_settlements
    self.count_settlements = self.locations.where('type_id = 2').count
    self.save
  end

  
end
