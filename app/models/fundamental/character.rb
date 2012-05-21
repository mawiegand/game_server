class Fundamental::Character < ActiveRecord::Base

  validates :identifier,  :uniqueness   => { :case_sensitive => true, :allow_blank => false }

  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  
  has_many :armies, :class_name => "Military::Army", :foreign_key => "owner_id"
  has_many :locations, :class_name => "Map::Location", :foreign_key => "owner_id"
  has_many :regions, :class_name => "Map::Region", :foreign_key => "owner_id"
  has_many :alliance_shouts, :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id"
  has_one :home_location, :class_name => "Map::Location", :foreign_key => "owner_id", :conditions => "type_id=2"
  has_many :shop_transactions, :class_name => "Shop::Transaction", :foreign_key => "character_id"
 
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
  
  def self.create_new_character(identifier)
    character = Fundamental::Character.new({
      identifier: identifier,
      name: 'WackyUser',
      frog_amount: 0,       # temporary hack
    });
    
    if !character.save
      raise InternalServerError.new('Could not create new character.') 
    end
    
    location = Map::Location.find_empty
    if !location || !character.claim_location(location)
      character.destroy
      raise InternalServerError.new('Could not claim an empty location.')
    end
    
    # HERE: create base (as soon as model implemented)
    location.type_id = 1 # base
    location.level = 1   # starting level
    location.save
    
    return character 
  end
  
  # should claim a location in a thread-safe way.... (e.g. check, that owner hasn't changed)
  def claim_location(location)
    location.owner_id = self.id
    location.owner_name = self.name
    location.alliance_id = self.alliance_id
    location.alliance_tag = self.alliance_tag
    location.save
  end
    
  
  def is_enemy_of?(opponent)
    return !self.is_neutral? && !opponent.is_neutral? && self.alliance != opponent.alliance  
  end
  
  def is_neutral?
    return self.alliance.nil?    
  end
  
  def lives_in_region?(region)
    return !self.locations.where("region_id = ?", region.id).empty?
  end
  
  def right_of_way_at(location)
    if location.right_of_way == 0          # all
      return true
    elsif location.right_of_way == 1       # no_enemies
      return !self.is_enemy_of?(location.owner)
    elsif location.right_of_way == 2       # no_neutrals
      return !self.is_enemy_of?(location.owner) && !self.is_neutral?  
    elsif location.right_of_way == 3       # no_residents
      return !self.is_enemy_of?(location.owner) && !self.is_neutral? && self.lives_in_region?(location.region)
    else                                   # forgotten anyone?
      return false
    end
  end  
  

end
