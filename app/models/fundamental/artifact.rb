class Fundamental::Artifact < ActiveRecord::Base


  has_one    :initiation,  :class_name => "Fundamental::ArtifactInitiation", :foreign_key => "artifact_id", :inverse_of => :artifact, :dependent => :destroy

  belongs_to :owner,       :class_name => "Fundamental::Character",  :foreign_key => "owner_id",      :inverse_of => :artifact

  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :artifact

  belongs_to :location,    :class_name => "Map::Location",           :foreign_key => "location_id",   :inverse_of => :artifact
  belongs_to :region,      :class_name => "Map::Region",             :foreign_key => "region_id",     :inverse_of => :artifacts

  before_save :update_region
  before_save :update_alliance

  scope :visible, where(['visible = ?', true])

  def artifact_type
    GameRules::Rules.the_rules.artifact_types[self.type_id]
  end

  def self.create_at_location_with_type(location, type_id)
    Military::Army.create_npc(location, Random.rand(50..1000))
    location.create_artifact({
      owner:     Fundamental::Character.find_by_id(1),
      region:    location.region,
      initiated: false,
      visible:   false,
      type_id:   type_id
    })
  end

  def capture_by_character(character)
    if Random.rand(100) <= 10  # 10% probability
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

  # 1. check neighbor nodes for empty locations
  # 2. if there's no empty location, check the neighbor nodes of the neighbor nodes
  # 3. if there's still no empty location, check whole map
  # 4. still no empty location? delete artifact
  def jump_to_neighbor_location
    locations = []
    self.region.node.neighbor_nodes.each do |neighbor_node|
      neighbor_node.region.locations.empty.each do |location|
        locations << location if location.artifact.nil?
      end
    end

    if locations.empty?
      self.region.node.neighbor_nodes.each do |first_neighbor_node|
        first_neighbor_node.neighbor_nodes.each do |second_neighbor_node|
          if second_neighbor_node != self.region.node
            second_neighbor_node.region.locations.empty.each do |location|
              locations << location if location.artifact.nil? && !locations.include?(location)
            end
          end
        end
      end
    end

    if locations.empty?
      Map::Location.empty.each do |location|
        locations << location if location.artifact.nil?
      end
    end

    if locations.empty?
      self.destroy
      return
    end

    new_location = locations[Random.rand(locations.count)]
    npc = Fundamental::Character.find_by_id(1)

    self.owner       = npc
    self.location    = new_location
    self.settlement  = nil
    self.initiated   = false
    self.visible     = false
    self.save

    Military::Army.create_npc(new_location, Random.rand(20..1000))
  end

  def move_to_base_of_character(character)
    self.owner            = character
    self.location         = character.home_location
    self.settlement       = character.home_location.settlement
    self.last_captured_at = Time.now
    self.initiated        = false
    self.visible          = !character.npc
    self.save
  end

  def initiation_duration
    formula = Util::Formula.parse_from_formula(artifact_type[:initiation_time], 'LEVEL')
    formula.apply(self.settlement.artifact_initiation_level)
  end

  def initiation_costs
    costs = {}
    return costs if artifact_type[:initiation_costs].nil?

    artifact_type[:initiation_costs].each do |resource_id, formula|
      f = Util::Formula.parse_from_formula(formula, 'LEVEL')
      costs[resource_id] = f.apply(self.owner.mundane_rank)
    end

    return costs
  end

  def make_visible
    self.visible = true
    self.save
  end

  def finish_initiation
    # if artifact owner is not settlement owner
    return false if self.owner != self.settlement.owner

    # if already initiated
    return false if self.initiated?

    # if there's no artifact stand or appropriate artifact stand level
    return false if self.settlement.artifact_initiation_level.nil? || settlement.artifact_initiation_level < 1

    self.last_initiated_at = Time.now
    self.initiated = true
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
