class Map::Location < ActiveRecord::Base
  
  belongs_to :region, :class_name => "Region", :foreign_key => "region_id"
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id"  

  has_many :armies, :class_name => "Military::Army", :foreign_key => "location_id"
  has_many :battles, :class_name => "Military::Battle", :inverse_of => :location
  has_one :settlement, :class_name => "Settlement::Settlement", :foreign_key => 'location_id', :inverse_of => :location


  def self.find_empty
    Map::Location.where("settlement_type_id = ?", 0).offset(Random.rand(Map::Location.where("settlement_type_id = ?", 0).count)).first
  end
  
  def garrison_army
    self.armies.each do |army|
      if army.garrison 
        return army
      end
    end
    
    return nil
  end
  
  # sets the owner_id and alliance_id to the new values. If theses
  # values changed, also updates the owner name and alliance tag.
  def set_owner_and_alliance(new_owner_id, new_alliance_id)
    if (new_owner_id != self.owner_id)
      self.owner_id = new_owner_id
      self.owner_name = self.owner.name     if !self.owner.nil?
    end
    if (new_alliance_id != self.alliance_id)
      self.alliance_id = new_alliance_id
      self.alliance_tag = self.alliance.tag if !self.alliance.nil?   
    end
  end

  def fortress?
    (!slot.nil?() && slot == 0)
  end
  
end
