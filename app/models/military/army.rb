class Military::Army < ActiveRecord::Base
  
  belongs_to :location, :class_name => "Location", :foreign_key => "location_id"
  belongs_to :region, :class_name => "Region", :foreign_key => "region_id"
  
  belongs_to :target_location, :class_name => "Location", :foreign_key => "target_location_id"
  belongs_to :target_region, :class_name => "Region", :foreign_key => "target_region_id"
  
end
