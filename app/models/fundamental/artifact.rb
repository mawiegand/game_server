require 'util/formula'

class Fundamental::Artifact < ActiveRecord::Base


  has_one    :initiation,  :class_name => "Fundamental::ArtifactInitiation", :foreign_key => "artifact_id", :inverse_of => :artifact, :dependent => :destroy

  belongs_to :owner,       :class_name => "Fundamental::Character",  :foreign_key => "owner_id",      :inverse_of => :artifact
  belongs_to :alliance,    :class_name => "Fundamental::Alliance",   :foreign_key => "alliance_id",   :inverse_of => :artifacts
  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :artifact

  belongs_to :location,    :class_name => "Map::Location",           :foreign_key => "location_id",   :inverse_of => :artifact
  belongs_to :region,      :class_name => "Map::Region",             :foreign_key => "region_id",     :inverse_of => :artifacts

  has_many    :character_resource_effects, :class_name => "Effect::ResourceEffect",         :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT]
  has_many    :alliance_resource_effects,  :class_name => "Effect::AllianceResourceEffect", :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::AllianceResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT]

  before_save :update_region

  after_save :propagate_changes_to_character
  after_save :propagate_changes_to_character_on_changed_possession

  after_save :propagate_effect_changes

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
    self.alliance    = nil
    self.location    = new_location
    self.settlement  = nil
    self.initiated   = false
    self.visible     = false
    self.save

    Military::Army.create_npc(new_location, Random.rand(20..1000))
  end

  def move_to_base_of_character(character)
    self.owner            = character
    self.alliance         = character.alliance
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

  def experience_production(mundane_rank)
    formula = Util::Formula.parse_from_formula(artifact_type[:experience_production], 'MRANK')
    formula.apply(mundane_rank)
  end

  def check_consistency
    #TODO compare initiated artifacts with artifact effects
    true
  end

  protected

    def update_region
      self.region = self.location.region
    end

    def propagate_owner_changes
      if self.owner_id_changed?
        propagate_changes_to_character_on_changed_possession
      end
      true
    end

    def propagate_changes_to_character_on_changed_possession
      owner_change = self.changes[:owner_id]
      unless owner_change.blank?
        old_owner = owner_change[0].nil? ? nil : Fundamental::Character.find_by_id(owner_change[0])
        new_owner = owner_change[1].nil? ? nil : Fundamental::Character.find_by_id(owner_change[1])

        # old user had no exp production if artifact is currently not initiated and initiation hasn't changed
        if !old_owner.nil? && !self.initiated && self.changes['initiated'].nil?
          old_owner['exp_production_rate'] = (old_owner['exp_production_rate'] || 0) - experience_production(old_owner.mundane_rank)
          old_owner.save
        end

        # new user has no exp production in artifact is currently not initiated
        if !new_owner.nil? && self.initiated
          new_owner['exp_production_rate'] = (new_owner['exp_production_rate'] || 0) + experience_production(new_owner.mundane_rank)
          new_owner.save
        end
      end
      true
    end

    def propagate_changes_to_character
      owner_change = self.changes[:owner_id]
      initiated_change = self.changes[:initiated]
      if !initiated_change.blank? && owner_change.blank?

        # if changed from initiated to not initiated
        if initiated_change[0]
          owner.exp_production_rate -= experience_production(owner.mundane_rank)
        else
          owner.exp_production_rate += experience_production(owner.mundane_rank)
        end
        owner.save
      end
      true
    end

    def add_character_resource_effect(owner_id, bonus)
      return if owner_id.nil?
      owner = Fundamental::Character.find_by_id(owner_id)
      owner.resource_pool.resource_effects.create({
        type_id:      Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT,
        resource_id:  bonus[:resource_id],
        bonus:        bonus[:bonus],
        origin_id:    self.id,
      }) unless owner.nil?
    end

    def remove_character_resource_effect(bonus)
      #owner = Fundamental::Character.find_by_id(owner_id) unless owner_id.nil?
      #owner.resource_pool.resource_effects.where('type_id = ?', Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT).destroy_all unless owner.nil?
      self.character_resource_effects.where('resource_id = ?', bonus[:resource_id]).destroy_all
    end

    def add_alliance_resource_effect(alliance_id, bonus)
      return if alliance_id.nil?
      alliance = Fundamental::Alliance.find_by_id(alliance_id)
      logger.debug "----------> add_alliance_resource_effect " + alliance.inspect
      alliance.resource_effects.create({
        type_id:      Effect::AllianceResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT,
        resource_id:  bonus[:resource_id],
        bonus:        bonus[:bonus],
        origin_id:    self.id,
      }) unless alliance.nil?
    end

    def remove_alliance_resource_effect(bonus)
      #alliance = Fundamental::Alliance.find_by_id(alliance_id) unless alliance_id.nil?
      #logger.debug "----------> remove_alliance_resource_effect " + alliance.inspect
      #alliance.resource_effects.where('type_id = ?', Effect::AllianceResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT).destroy_all unless alliance.nil?
      self.alliance_resource_effects.where('resource_id = ?', bonus[:resource_id]).destroy_all
    end

    def propagate_effect_changes
      owner_change       = self.changes[:owner_id]
      alliance_change    = self.changes[:alliance_id]

      initiated_change = self.changes[:initiated]
      initiated_before = initiated_change.nil? ? initiated : !initiated
      initiated_after  = initiated

      # if owner changed
      if !owner_change.nil?
        if initiated_before
          # effekt beim alten user löschen
          self.artifact_type[:production_bonus].each do |bonus|
            remove_character_resource_effect(bonus) if bonus[:domain_id] == 0
          end
        end
        if initiated_after
          # effekt beim neuen user eintragen
          self.artifact_type[:production_bonus].each do |bonus|
            add_character_resource_effect(owner_change[1], bonus) if bonus[:domain_id] == 0
          end
        end
      end

      # if alliance changed
      if !alliance_change.nil?
        logger.debug "----------> artifact alliance_change #{initiated_before} #{initiated_after}" + alliance_change.inspect

        if initiated_before
          # effekt bei der alten allianz löschen
          self.artifact_type[:production_bonus].each do |bonus|
            remove_alliance_resource_effect(bonus) if bonus[:domain_id] == 2
          end
        end
        if initiated_after
          # effekt bei neuer allianz eintragen
          self.artifact_type[:production_bonus].each do |bonus|
            add_alliance_resource_effect(alliance_change[1], bonus) if bonus[:domain_id] == 2
          end
        end
      end

      logger.debug "----------> ally " + initiated_change.inspect

      # if only the initiation state changed
      if owner_change.nil? && alliance_change.nil? && !initiated_change.nil?
        if initiated_before
          # effekt beim aktuellen user_loeschen
          self.artifact_type[:production_bonus].each do |bonus|
            remove_character_resource_effect(bonus) if bonus[:domain_id] == 0
            remove_alliance_resource_effect(bonus)  if bonus[:domain_id] == 2
          end
        end
        if initiated_after
          # effekt beim aktuellen user eintragen
          self.artifact_type[:production_bonus].each do |bonus|
            logger.debug "----------> initiated_after " + bonus.inspect
            add_character_resource_effect(owner_id, bonus)    if bonus[:domain_id] == 0
            logger.debug "----------> initiated_after " + bonus.inspect
            add_alliance_resource_effect(alliance_id, bonus)  if bonus[:domain_id] == 2
          end
        end
      end
    end
end
