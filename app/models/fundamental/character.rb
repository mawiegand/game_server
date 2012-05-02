class Fundamental::Character < ActiveRecord::Base

  validates :identifier,  :uniqueness   => { :case_sensitive => true, :allow_blank => false }

  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  
  has_many :armies, :class_name => "Military::Army", :foreign_key => "owner_id"
  has_many :locations, :class_name => "Map::Location", :foreign_key => "owner_id"
  has_many :regions, :class_name => "Map::Region", :foreign_key => "owner_id"
  has_many :alliance_shouts, :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id"
  has_one :home_location, :class_name => "Map::Location", :foreign_key => "owner_id", :conditions => "type_id=2"
 
  @identifier_regex = /[a-z]{16}/i 
  
  def self.find_by_id_or_identifier(user_identifier)
    
    identity = Fundamental::Character.find_by_id(user_identifier) if Fundamental::Character.valid_id?(user_identifier)
    identity = Fundamental::Character.find_by_identifier(user_identifier) if identity.nil? && Fundamental::Character.valid_identifier?(user_identifier)
    
    return identity
  end
  
  def self.valid_identifier?(identifier)
    identifier.index(@identifier_regex) != nil
  end
  
  def self.valid_id?(id)
    id.index(/^[1-9]\d*$/) != nil
  end
  
end
