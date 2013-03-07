class Map::Location < ActiveRecord::Base
  
  belongs_to :region,     :class_name => "Region",                 :foreign_key => "region_id",   :inverse_of => :locations
  belongs_to :alliance,   :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"  
  belongs_to :owner,      :class_name => "Fundamental::Character", :foreign_key => "owner_id"  

  has_many   :armies,     :class_name => "Military::Army",         :foreign_key => "location_id", :inverse_of => :location
  has_many   :battles,    :class_name => "Military::Battle",                                      :inverse_of => :location
  has_one    :settlement, :class_name => "Settlement::Settlement", :foreign_key => 'location_id', :inverse_of => :location

  has_one    :artifact,   :class_name => "Fundamental::Artifact",  :foreign_key => "location_id", :inverse_of => :location

  before_save :move_artifact_if_necessary

  scope :excluding_fortress_slots,  where(['slot <> ?', 0])
  scope :owned_by,                  lambda { |character| where(:owner_id => character.id) }
  scope :empty,                     where("settlement_type_id = ?", 0)

  def self.find_empty
    Map::Location.empty.offset(Random.rand(Map::Location.empty.count)).first
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
    
    # select from owned regions, if any free location
    
    target_location = nil
    inviting_alliance.regions.order("updated_at ASC").each do |region|   # pseudo random order
      if target_location.nil? 
        num_free_locations = region.locations.empty.count
        if num_free_locations > 0
          return target_location = region.locations.empty.offset(Random.rand(num_free_locations)).first
        end
      end
    end
    
    return target_location unless target_location.nil?
    
    # select from regions that have at least the home settlement of an alliance player in it.

    inviting_alliance.members.order("updated_at ASC").each do |character|   # pseudo random order
      if target_location.nil? 
        num_free_locations = character.home_location.region.locations.empty.count
        if num_free_locations > 0
          return target_location = character.home_location.region.locations.empty.offset(Random.rand(num_free_locations)).first
        end
      end
    end
    
    target_location
  end  
    


  def garrison_army
    self.armies.each do |army|
      if army.garrison 
        return army
      end
    end
    nil
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
    end
  end
  
  def remove_settlement
    self.settlement_type_id = Settlement::Settlement::TYPE_NONE
    self.settlement_level = nil
    self.count_armies = nil
    self.owner_id = nil
    self.owner_name = nil
    self.visible = nil
    self.right_of_way = 0
    self.settlement_score = 0
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
