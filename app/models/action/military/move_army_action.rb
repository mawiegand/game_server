class Action::Military::MoveArmyAction < ActiveRecord::Base
  belongs_to :army, :class_name => "Military::Army", :foreign_key => "army_id"
  
  belongs_to :location, :class_name => "Map::Location", :foreign_key => "starting_location_id"
  belongs_to :region, :class_name => "Map::Region", :foreign_key => "starting_region_id"
  
  belongs_to :target_location, :class_name => "Map::Location", :foreign_key => "target_location_id"
  belongs_to :target_region, :class_name => "Map::Region", :foreign_key => "target_region_id"
end
