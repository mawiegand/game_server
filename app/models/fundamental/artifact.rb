class Fundamental::Artifact < ActiveRecord::Base


  has_one    :initiation,  :class_name => "Fundamental::ArtifactInitiation", :foreign_key => "artifact_id", :inverse_of => :artifact, :dependent => :destroy

  belongs_to :owner,       :class_name => "Fundamental::Character",  :foreign_key => "owner_id",      :inverse_of => :artifact

  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :artifact

  belongs_to :location,    :class_name => "Map::Location",           :foreign_key => "location_id",   :inverse_of => :artifact
  belongs_to :region,      :class_name => "Map::Region",             :foreign_key => "region_id",     :inverse_of => :artifacts

  before_save :update_region
  before_save :update_alliance

  scope :visible, joins(:owner).where(['fundamental_characters.npc = ?', false])

  def artifact_type
    GameRules::Rules.the_rules.artifact_types[self.type_id]
  end

  def self.create_at_location_with_type(location, type_id)
    Military::Army.create_npc(location, Random.rand(4..6))
    location.create_artifact({
      owner:     Fundamental::Character.find_by_id(1),
      region:    location.region,
      initiated: false,
      type_id:   type_id
    })
  end

  def capture_by_character(character)
    logger.debug "-------> capture_by_character"

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
    logger.debug "-------> jump_to_neighbor_location"

    locations = []
    self.region.node.neighbor_nodes.each do |neighbor_node|
      neighbor_node.region.locations.empty.each do |location|
        locations << location if location.artifact.nil?
      end
    end

    new_location = locations[Random.rand(locations.count)]
    logger.debug "-------> jump_to_neighbor_location #{new_location.slot} #{new_location.region.node.path}"

    npc = Fundamental::Character.find_by_id(1)

    self.owner       = npc
    self.location    = new_location
    self.settlement  = nil
    self.initiated   = false
    self.save

    Military::Army.create_npc(new_location, Random.rand(4..6))
  end

  def move_to_base_of_character(character)
    logger.debug "-------> move_to_base_of_character"
    self.owner       = character
    self.location    = character.home_location
    self.settlement  = character.home_location.settlement
    self.initiated   = false
    self.save
  end

  def initiation_duration
    formula = Util::Formula.parse_from_formula(artifact_type[:initiation_time], 'LEVEL')
    formula.apply(self.settlement.artifact_initiation_level)
  end

  def initiation_costs
    logger.debug "-------> initiation_costs #{self.owner.mundane_rank}"
    costs = {}
    return costs if artifact_type[:initiation_costs].nil?

    artifact_type[:initiation_costs].each do |resource_id, formula|
      f = Util::Formula.parse_from_formula(formula, 'MRANK')
      costs[resource_id] = f.apply(self.owner.mundane_rank)
    end

    logger.debug "-------> initiation_costs  " + costs.inspect

    return costs
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
