class Fundamental::Treasure < ActiveRecord::Base

  belongs_to :specific_character, :class_name => "Fundamental::Character", :foreign_key => "specific_character_id",    :inverse_of => :poacher_treasures

  belongs_to :location,           :class_name => "Map::Location",          :foreign_key => "location_id",              :inverse_of => :treasures
  belongs_to :region,             :class_name => "Map::Region",            :foreign_key => "region_id",                :inverse_of => :treasures

  belongs_to :army,               :class_name => "Military::Army",         :foreign_key => "army_id",                  :inverse_of => :treasure

end
