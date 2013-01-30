class Fundamental::Artifact < ActiveRecord::Base

  belongs_to :owner,       :class_name => "Fundamental::Character",  :foreign_key => "owner_id",      :inverse_of => :artifact

  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :artifact

  belongs_to :location,    :class_name => "Map::Location",           :foreign_key => "location_id",   :inverse_of => :artifact
  belongs_to :region,      :class_name => "Map::Region",             :foreign_key => "region_id",     :inverse_of => :artifacts

  before_save :update_region
  before_save :update_alliance

  def self.create_at_location_with_type(location, type_id)
    Military::Army.create_npc(location, Random.rand(400..600))
    location.create_artifact({
      owner:    Fundamental::Character.find_by_id(1),
      region:   location.region,
      active:   false,
      type_id:  type_id
    })
  end

  def capture_by_character(character)
    if false #Random.rand(100) >= 10  # 10% probability
      #jump
      self.jump_to_neighbor_location
    else
      #capture
      if character.artifact.nil?
        self.move_to_base_of_character(character)
      else
        self.jump_to_neighbor_location
      end
    end
  end

  def jump_to_neighbor_location
    new_location = self.region.locations.find_empty
    npc = Fundamental::Character.find_by_id(1)
    self.owner       = npc
    self.location    = new_location
    self.settlement  = nil
    self.active      = false
    self.save
  end

  def move_to_base_of_character(character)
    self.owner       = character
    self.location    = character.home_location
    self.settlement  = character.home_location.settlement
    self.active      = false
    self.save
  end

  protected

    def update_region
      self.region = self.location.region
    end

    def update_alliance
      #self.alliance      = self.owner.alliance.nil? ? nil : self.owner.alliance
      #self.alliance_tag  = self.owner.alliance.nil? ? nil : self.owner.alliance.tag
    end

end
