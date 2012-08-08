class Map::Region < ActiveRecord::Base
  
  belongs_to :node,            :class_name => "Node",                   :foreign_key => "node_id"
  belongs_to :alliance,        :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"  
  belongs_to :owner,           :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  
  has_many :locations,         :class_name => "Location",               :foreign_key => "region_id",   :inverse_of => :region, :order => :slot,        :dependent => :destroy
  has_one  :fortress_location, :class_name => "Location",               :foreign_key => "region_id",   :inverse_of => :region, :conditions => 'slot = 0'
  has_one  :fortress,          :class_name => "Settlement::Settlement", :foreign_key => "region_id",   :inverse_of => :region, :conditions => ['owns_region = ?', true]
  has_many :settlements,       :class_name => "Settlement::Settlement", :foreign_key => 'region_id',   :inverse_of => :region
  has_many :armies,            :class_name => "Military::Army",         :foreign_key => "region_id",   :inverse_of => :region
  
  has_many :battles,           :class_name => "Military::Battle", :inverse_of => :region
  
  def recount_settlements
    self.count_settlements = self.locations.where('settlement_type_id = 2').count
    self.save
  end

  # sets the owner_id and alliance_id to the new values. If theses
  # values changed, also updates the owner name and alliance tag.
  def set_owner_and_alliance(new_owner_id, new_alliance_id)
    if (new_owner_id != self.owner_id)
      self.owner_id = new_owner_id
      self.owner_name = self.owner.nil? ? nil : self.owner.name     
    end
    if (new_alliance_id != self.alliance_id)
      self.alliance_id = new_alliance_id
      self.alliance_tag = self.alliance.nil? ? nil : self.alliance.tag    
    end
  end
  
end
