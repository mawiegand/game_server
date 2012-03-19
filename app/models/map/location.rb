class Map::Location < ActiveRecord::Base
  
  belongs_to :region, :class_name => "Region", :foreign_key => "region_id"

end
