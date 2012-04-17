class Military::Army < ActiveRecord::Base
  
  belongs_to :location, :class_name => "Map::Location", :foreign_key => "location_id"
  belongs_to :region, :class_name => "Map::Region", :foreign_key => "region_id"
  
  belongs_to :target_location, :class_name => "Map::Location", :foreign_key => "target_location_id"
  belongs_to :target_region, :class_name => "Map::Region", :foreign_key => "target_region_id"
  
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  
  has_one    :movement_command, :class_name => "Action::Military::MoveArmyAction", :foreign_key => "army_id"
    
  after_save :set_parent_change_timestamps
  
  
  def owned_by?(character_id)
    self.owner_id === character_id
  end
  
  def moving?
    !self.target_location_id.blank? || self.mode === 1 # 1 : moving?!
  end
  
  def fighting?
    self.mode === 2 # 2: fighting?
  end
  
  private
  
    def set_parent_change_timestamps
      self.region.armies_changed_at = self.updated_at
      self.region.save
      
      self.location.armies_changed_at = self.updated_at
      self.location.save
      
      return true   # must return true as returning false breaks the callback chain
    end
  
end
