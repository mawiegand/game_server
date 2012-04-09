class Fundamental::Character < ActiveRecord::Base

  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  
  has_many :armies, :class_name => "Military::Army", :foreign_key => "owner_id"
  has_many :locations, :class_name => "Map::Location", :foreign_key => "owner_id"
  has_many :regions, :class_name => "Map::Region", :foreign_key => "owner_id"
  has_one :home_location, :class_name => "Map::Location", :foreign_key => "owner_id", :conditions => "type_id=2"
end
