class Fundamental::Character < ActiveRecord::Base

  validates :identifier,  :uniqueness   => { :case_sensitive => true, :allow_blank => false }

  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"  
  
  has_one  :resource_pool, :class_name => "Fundamental::ResourcePool", :foreign_key => "character_id", :inverse_of => :owner
  has_one  :home_location, :class_name => "Map::Location", :foreign_key => "owner_id", :conditions => "type_id=2"
  
  has_one  :inbox, :class_name => "Messaging::Inbox", :foreign_key => "owner_id", :inverse_of => :owner
  has_one  :outbox, :class_name => "Messaging::Outbox", :foreign_key => "owner_id", :inverse_of => :owner
  has_one  :archive, :class_name => "Messaging::Archive", :foreign_key => "owner_id", :inverse_of => :owner

  has_many :armies, :class_name => "Military::Army", :foreign_key => "owner_id"
  has_many :locations, :class_name => "Map::Location", :foreign_key => "owner_id"
  has_many :regions, :class_name => "Map::Region", :foreign_key => "owner_id"
  has_many :alliance_shouts, :class_name => "Fundamental::AllianceShout", :foreign_key => "alliance_id"
  has_many :shop_transactions, :class_name => "Shop::Transaction", :foreign_key => "character_id"
  has_many :settlements, :class_name => "Settlement::Settlement", :foreign_key => "owner_id"


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
  
  def self.create_new_character(identifier, name)
    character = Fundamental::Character.new({
      identifier: identifier,
      frog_amount: 0,       # temporary hack
      name: name,
    });
    
    if !character.save
      raise InternalServerError.new('Could not create new character.') 
    end
    
    location = Map::Location.find_empty
    if !location || !character.claim_location(location)
      character.destroy
      raise InternalServerError.new('Could not claim an empty location.')
    end
    
    Settlement::Settlement.create_settlement_at_location(location, 2, character)  # 2: home base
        
    character.base_location_id = location.id
    character.base_region_id = location.region_id
    character.base_node_id = location.region.node_id
    
    if !character.save
      raise InternalServerError.new('Could not save the base of the character.')
    end

    character.create_resource_pool
    
    character.create_inbox
    character.create_outbox
    character.create_archive
    
    return character 
  end
  
  # should claim a location in a thread-safe way.... (e.g. check, that owner hasn't changed)
  def claim_location(location)
    # here block location, in case it's not yet blocked.  blocked lactions must be ignored by find_empty
    return true
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
