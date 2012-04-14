class Fundamental::Alliance < ActiveRecord::Base
  has_many :members, :class_name => "Fundamental::Character", :foreign_key => "alliance_id"
  has_many :armies, :class_name => "Military::Army", :foreign_key => "alliance_id"
  has_many :locations, :class_name => "Map::Location", :foreign_key => "alliance_id"
  has_many :regions, :class_name => "Map::Region", :foreign_key => "alliance_id"
  has_many :shouts, :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id", :order => "created_at DESC"
end
