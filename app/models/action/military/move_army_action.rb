class Action::Military::MoveArmyAction < ActiveRecord::Base
  belongs_to :army, :class_name => "Military::Army", :foreign_key => "army_id"
  
  belongs_to :location, :class_name => "Map::Location", :foreign_key => "starting_location_id"
  belongs_to :region, :class_name => "Map::Region", :foreign_key => "starting_region_id"
  
  belongs_to :target_location, :class_name => "Map::Location", :foreign_key => "target_location_id"
  belongs_to :target_region, :class_name => "Map::Region", :foreign_key => "target_region_id"
  
  has_one    :event, :class_name => "Event::Event", :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'action_military_move_army_action'"

  
  def valid_action?(role = :character)
    # check whether this movement is possible and allowed (neighbouring positions, starts at present position, owned by current character)
    raise BadRequestError.new('army not found') if self.army.blank?
    raise BadRequestError.new('could not get army\'s current location') if self.starting_location_id != army.location_id
    raise BadRequestError.new('could not get army\'s current region') if self.starting_region_id != army.region_id
    
        # check movement possible? (starting and target location neighbours?)
        
    if (role != :owner && role != :admin  && role != staff) || self.army.moving? || self.army.fighting?
      return false
    end
    
    if (self.army.ap_present < 1.0)   # enough action points?
      return false
    end
    
    return true        
  end
  
end
