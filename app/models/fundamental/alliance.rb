class Fundamental::Alliance < ActiveRecord::Base
  has_many :members, :class_name => "Fundamental::Character", :foreign_key => "alliance_id"
  has_many :armies, :class_name => "Military::Army", :foreign_key => "alliance_id"
  has_many :locations, :class_name => "Map::Location", :foreign_key => "alliance_id"
  has_many :regions, :class_name => "Map::Region", :foreign_key => "alliance_id"
  has_many :shouts, :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id", :order => "created_at DESC"
  
  def add_character(character)
    character.alliance_tag = self.alliance_tag
    character.alliance_id = self.alliance_id
    character.save
  end
  
  def remove_character(character)
    character.alliance_tag = nil
    character.alliance_id = nil
    character.save
  end
  
end
