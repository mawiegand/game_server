class Map::Location < ActiveRecord::Base
  
  belongs_to :region,     :class_name => "Region",                 :foreign_key => "region_id",   :inverse_of => :locations
  belongs_to :alliance,   :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"  
  belongs_to :owner,      :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  belongs_to :claiming_character, :class_name => "Fundamental::Character", :foreign_key => "claimed_by"  

  has_many   :armies,     :class_name => "Military::Army",         :foreign_key => "location_id", :inverse_of => :location
  has_many   :battles,    :class_name => "Military::Battle",                                      :inverse_of => :location
  has_one    :settlement, :class_name => "Settlement::Settlement", :foreign_key => 'location_id', :inverse_of => :location

  has_one    :artifact,   :class_name => "Fundamental::Artifact",  :foreign_key => "location_id", :inverse_of => :location

  before_save :move_artifact_if_necessary

  scope :excluding_fortress_slots,  where(['slot <> ?', 0])
  scope :owned_by,                  lambda { |character| where(:owner_id => character.id) }
  scope :empty,                     where("settlement_type_id = ?", Settlement::Settlement::TYPE_NONE)
  scope :non_empty,                 where("settlement_type_id != ?", Settlement::Settlement::TYPE_NONE)
  scope :home_bases,                where("settlement_type_id = ?", Settlement::Settlement::TYPE_HOME_BASE)

  def self.find_empty
    Map::Location.empty.offset(Random.rand(Map::Location.empty.count)).first
  end

  def self.find_empty_with_neighbors
    # get all home_base locations
    home_bases = Map::Location.home_bases.select { |base| !base.owner_name.include?('Wacky')  }
    # if map is empty home_bases is empty as well. choose any location
    return Map::Location.find_empty if home_bases.empty?
    # to avoid a single cluster, distribute first 100 users over the whole map
    return Map::Location.find_empty if home_bases.count < 100
    # pick one randomly
    home_base = home_bases[Random.rand(home_bases.count)]
    # get neighbor nodes of picked location
    neighbor_nodes = home_base.region.node.neighbor_nodes
    # sort them by settlement count
    neighbor_nodes.sort! { |a,b| a.region.settlements.count <=> b.region.settlements.count }
    # first neighbor node now contains region with fewest settlements
    target_region = neighbor_nodes.first.region
    # count empty locations of this region
    free_locations = target_region.locations.empty.count
    # if no locations available choose any other from whole map
    return Map::Location.find_empty if free_locations == 0
    # return randomly chosen empty location of neighbor region
    target_region.locations.empty.offset(Random.rand(free_locations)).first
  end

  def self.find_empty_without_army
    empty_locations = Map::Location.all - Map::Location.joins(:armies)
    return nil if empty_locations.empty?
    empty_locations[Random.rand(empty_locations.count)]
  end

  def self.location_for_player_invitation(invitation_code)
    inviting_region = Map::Region.find_by_invitation_code(invitation_code)
    return nil if inviting_region.nil?
    
    free_locations = inviting_region.locations.empty.count
    return nil if free_locations == 0
    
    target_location = inviting_region.locations.empty.offset(Random.rand(free_locations)).first
    target_location
    # return target_location unless target_location.nil?  # no location available in invitung region

    # try to find free location in other regions that are controlled vy inviting player or
    # try to find free location in neighboring locations
  end

  def self.location_for_alliance_invitation(invitation_code)
    inviting_alliance = Fundamental::Alliance.find_by_invitation_code(invitation_code)
    return nil if inviting_alliance.nil?

    max_home_bases = GAME_SERVER_CONFIG['max_home_bases_in_region_for_alliance_invitation']
    regions = []

    # select from owned regions, if any free location
    inviting_alliance.regions.order("updated_at ASC").each do |region|   # pseudo random order
      empty_locations  = region.locations.empty
      home_bases_count = region.locations.home_bases.count
      if empty_locations.count > 0 && home_bases_count < max_home_bases
        return empty_locations.offset(Random.rand(empty_locations.count)).first
      end
      regions << region
    end

    # select from regions that have at least the home settlement of an alliance player in it.
    inviting_alliance.members.order("updated_at ASC").each do |character|   # pseudo random order
      region = character.home_location.region
      empty_locations = region.locations.empty
      home_bases_count = region.locations.home_bases.count
      if empty_locations.count > 0 && home_bases_count < max_home_bases
        return empty_locations.offset(Random.rand(empty_locations.count)).first
      end
      regions << region
    end

    # select from owned regions, if any free location
    regions.each do |region|   # pseudo random order
      region.node.neighbor_nodes.each do |neighbor_node|
        empty_locations  = neighbor_node.region.locations.empty
        home_bases_count = neighbor_node.region.locations.home_bases.count
        if empty_locations.count > 0 && home_bases_count < max_home_bases
          return empty_locations.offset(Random.rand(empty_locations.count)).first
        end
      end
    end

    nil
  end
  
  def self.test_neighbours_of(node, test, max_tests = 30)    
    visited_node_ids = { node.id => true }
    nodes            = node.neighbor_nodes
    target           = nil
    count            = 0 
    
    begin
      node, *tail = nodes                  # pop the first node in the queue
      tail = tail || []                    # make sure it's always an array and never nil
      
      if visited_node_ids[node.id].nil?
        visited_node_ids[node.id] = true
        count += 1
        
        if send(test, node)
          return node
        elsif count < max_tests
          tail.push(*node.neighbor_nodes)  # flatten the result array and push them to the end of the list.
        end
      end
      
      nodes = tail
    end while !nodes.empty?   
  end
  
  def self.is_valid_starting_position(node)
    if !node.nil? && node.leaf?
      free_locations = node.region.locations.empty.count
      home_bases_count = node.region.locations.home_bases.count
      if free_locations > 0 && home_bases_count < GAME_SERVER_CONFIG['max_home_bases_in_region_for_geo']
        return true
      end
    end
    return false
  end
  
  def self.free_location_in(node)
    free_locations = node.region.locations.empty.count
    home_bases_count = node.region.locations.home_bases.count
    if free_locations > 0 && home_bases_count < GAME_SERVER_CONFIG['max_home_bases_in_region_for_geo']
      target_location = node.region.locations.empty.offset(Random.rand(free_locations)).first
    end
    target_location
  end
  
  def self.claim!(character)
    self.claiming_character = character
    self.save
  end
    

  def self.location_with_geo_coords(coords)
    target_location = nil
    node = Map::Node.find_by_coords(coords['latitude'], coords['longitude'])
    if !node.nil?
      target_location = Map::Location.free_location_in(node)
    
      if target_location.nil?
        node = Map::Location::test_neighbours_of(node, :is_valid_starting_position) 
        if !node.nil?
          target_location = Map::Location.free_location_in(node)
        end
      end
    end
    target_location
  end
  
  # this method iteratively searches a given nodes neighbours in a breadth-first search.
  # it uses a list to remember nodes that wait to be expanded and a hash to remember
  # already visited nodes. will return a location in the first region that has at
  # least two empty spots and is not already settled by the character. 
  def self.location_for_oupost_in_starter_package(character)
    home_base = character.bases[0]
    home_node = home_base.region.node
    
    visited_node_ids = { home_node.id => true }
    
    nodes            = home_node.neighbor_nodes
    
    target           = nil
    
    begin
      node, *tail = nodes                  # pop the first node in the queue
      tail = tail || []                    # make sure it's always an array and never nil
      
      if visited_node_ids[node.id].nil?
        visited_node_ids[node.id] = true
        
        if node.region.locations.empty.count > 1 && node.region.settleable_by?(character)
          target = node
        else
          tail.push(*node.neighbor_nodes)  # flatten the result array and push them to the end of the list.
        end
      end
      
      nodes = tail
      
    end while target.nil? && !nodes.empty?
    
    if !target.nil?
      target.region.locations.empty[0]
    else 
      nil
    end
    
  end
  
  def valid_movement_target_for_army?(army)
    if army.location.fortress?
      # check neighboring fortresses
      self.region == army.region || (self.fortress? && army.region.node.neighbor_nodes.include?(self.region.node))
    else
      # check same region
      self.region == army.region
    end
  end


  def garrison_army
    self.armies.each do |army|
      if army.garrison 
        return army
      end
    end
    nil
  end

  def set_special_image(owner)
    if !self.settlement.nil? && self.settlement.home_base? && owner.divine_supporter?
      self.image_id = 1
    else
      self.image_id = nil
    end
  end
  
  # sets the owner_id and alliance_id to the new values. If theses
  # values changed, also updates the owner name and alliance tag.
  def set_owner_and_alliance(new_owner, new_alliance)
    if new_owner != self.owner
      self.owner = new_owner
      self.owner_name = self.owner.nil? ? nil : self.owner.name     
    end
    if new_alliance != self.alliance
      self.alliance = new_alliance
      self.alliance_tag = self.alliance.nil? ? nil : self.alliance.tag
      self.alliance_color = self.alliance.nil? ? nil : self.alliance.color
    end
    self.set_special_image(new_owner)
  end
  
  def place_settlement(settlement)
    self.region = settlement.region
    self.settlement_type_id = settlement.type_id
    self.settlement_level = settlement.level
    self.owner = settlement.owner
    self.owner_name = settlement.owner.name
    self.alliance = settlement.alliance
    self.alliance_tag = settlement.alliance_tag
    self.alliance_color = settlement.alliance_color
    self.set_special_image(settlement.owner)
    self.visible = true
    self.settlement_score = settlement.score
    self.save
  end
  
  def remove_settlement
    self.settlement_type_id = Settlement::Settlement::TYPE_NONE
    self.settlement_level = nil
    self.count_armies = nil
    self.owner_id = nil
    self.owner_name = nil
    self.visible = false
    self.right_of_way = 0
    self.settlement_score = 0
    self.image_id = nil
    self.save
  end

  def empty?
    self.settlement_type_id == Settlement::Settlement::TYPE_NONE
  end
  
  def fortress?
    (!slot.nil?() && slot == 0)
  end
  
  def can_be_retreated_to?(character)
    !owner.nil? && (owner == character || owner.is_ally_of?(character))
  end
  
  def can_found_outpost_here?
    !fortress? && settlement.nil?
  end

  protected

    def move_artifact_if_necessary
      if !artifact.nil? && artifact.owner.npc? && !settlement_type_id_change.nil? && settlement_type_id_change[0] == Settlement::Settlement::TYPE_NONE
        artifact.jump_to_neighbor_location
      end
    end

end
