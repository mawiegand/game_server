require 'util/formula'

class Fundamental::Artifact < ActiveRecord::Base


  has_one    :initiation,  :class_name => "Fundamental::ArtifactInitiation", :foreign_key => "artifact_id", :inverse_of => :artifact, :dependent => :destroy

  belongs_to :owner,       :class_name => "Fundamental::Character",  :foreign_key => "owner_id",      :inverse_of => :artifact
  belongs_to :alliance,    :class_name => "Fundamental::Alliance",   :foreign_key => "alliance_id",   :inverse_of => :artifacts
  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :artifact

  belongs_to :location,    :class_name => "Map::Location",           :foreign_key => "location_id",   :inverse_of => :artifact
  belongs_to :region,      :class_name => "Map::Region",             :foreign_key => "region_id",     :inverse_of => :artifacts

  belongs_to :army,        :class_name => "Military::Army",          :foreign_key => "army_id",       :inverse_of => :artifact

  has_many   :character_resource_effects, :class_name => "Effect::ResourceEffect",         :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT]
  has_many   :alliance_resource_effects,  :class_name => "Effect::AllianceResourceEffect", :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::AllianceResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT]

  has_many   :character_construction_effects, :class_name => "Effect::ConstructionEffect",         :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::ConstructionEffect::CONSTRUCTION_EFFECT_TYPE_ARTIFACT]
  has_many   :alliance_construction_effects,  :class_name => "Effect::AllianceConstructionEffect", :foreign_key => "origin_id", :conditions => ["type_id = ?", Effect::AllianceConstructionEffect::CONSTRUCTION_EFFECT_TYPE_ARTIFACT]

  before_save :update_region

  after_save :propagate_changes_to_character
  after_save :propagate_changes_to_character_on_changed_possession
  after_save :propagate_changes_to_victory_progress
  after_save :propagate_effect_changes

  scope :visible, where('visible = ?', true)

  def artifact_type
    GameRules::Rules.the_rules.artifact_types[self.type_id]
  end

  def self.create_at_location_with_type(location, type_id, npc_size_min, npc_size_max)
    army = Military::Army.create_npc(location, Random.rand(npc_size_min..npc_size_max))
    location.create_artifact({
      owner:     Fundamental::Character.find_by_id(1),
      region:    location.region,
      army:      army,
      initiated: false,
      visible:   false,
      type_id:   type_id,
    })
  end

  def capture_by_character(character)
    return false if !character.moved_at.nil? && character.moved_at >= GAME_SERVER_CONFIG['artifact_capture_disable_time'].hours.ago
    if Random.rand(1.0) < GAME_SERVER_CONFIG['artifact_jump_probability']
      self.jump_to_neighbor_location
      false
    else
      #capture
      if character.artifact.nil?
        self.move_to_base_of_character(character)
        true
      else
        self.jump_to_neighbor_location
        false
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
    else
      new_location = locations[Random.rand(locations.count)]
      npc = Fundamental::Character.find_by_id(1)

      avg_size_armies = Military::Army.non_npc.non_garrison.average(:size_present) || 20
      max_size_armies = Military::Army.non_npc.non_garrison.maximum(:size_present) || 400

      npc_army = Military::Army.create_npc(new_location, Random.rand(avg_size_armies..(2 * max_size_armies)))

      self.owner       = npc
      self.alliance    = nil
      self.location    = new_location
      self.settlement  = nil
      self.army        = npc_army
      self.initiated   = false
      self.visible     = false
      self.save
    end
  end

  def move_to_base_of_character(character)
    self.owner            = character
    self.alliance         = character.alliance
    self.location         = character.home_location
    self.settlement       = character.home_location.settlement
    self.army             = character.home_location.settlement.garrison_army
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

    costs
  end

  def make_visible
    self.visible = true
    self.save
  end

  def make_invisible
    self.visible = false
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
    if self.initiated? && !self.artifact_type[:experience_production].nil?
      formula = Util::Formula.parse_from_formula(artifact_type[:experience_production], 'MRANK')
      formula.apply(mundane_rank)
    else
      0
    end
  end

  def check_consistency
    check_resource_effects
    check_construction_effects
  end

  def check_resource_effects
    if self.initiated? && !self.owner.npc? && !self.artifact_type[:production_bonus].nil?
      self.artifact_type[:production_bonus].each do |bonus|
        if bonus[:domain_id] == 0 && self.character_resource_effects.where('resource_id = ?', bonus[:resource_id]).empty?
          add_character_resource_effect(self.owner.id, bonus)
        elsif bonus[:domain_id] == 2 && !self.alliance.nil? && self.alliance_resource_effects.where('resource_id = ?', bonus[:resource_id]).empty?
          add_alliance_resource_effect(self.alliance.id, bonus)
        end
      end
      # TODO remove unnecessary effects aswell
    end
    unless self.initiated?
      self.character_resource_effects.destroy_all
      self.alliance_resource_effects.destroy_all
    end
    true
  end

  def check_construction_effects
    if self.initiated? && !self.owner.npc? && !self.artifact_type[:construction_bonus].nil?
      self.artifact_type[:construction_bonus].each do |bonus|
        if bonus[:domain_id] == 0 && self.character_construction_effects.empty?
          add_character_construction_effect(self.owner.id, bonus)
        elsif bonus[:domain_id] == 2 && !self.alliance.nil? && self.alliance_resource_effects.empty?
          add_alliance_construction_effect(self.alliance.id, bonus)
        end
      end
      # TODO remove unnecessary effects aswell
    end
    unless self.initiated?
      self.character_construction_effects.destroy_all
      self.alliance_construction_effects.destroy_all
    end
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
      unless self.artifact_type[:experience_production].nil?
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
      end
      true
    end

    def increment_victory_progress(alliance)
      if alliance.artifacts.where('type_id = ? AND initiated = ?', self.type_id, true).count == 1
        victory_progress = alliance.victory_progress_for_type(Fundamental::VictoryProgress::VICTORY_TYPE_ARTIFACTS)
        unless victory_progress.nil?
          victory_progress.increment(:fulfillment_count)
          victory_progress.save
        end
      end
    end

    def decrement_victory_progress(alliance)
      if alliance.artifacts.where('type_id = ? AND initiated = ?', self.type_id, true).count == 0
        victory_progress = alliance.victory_progress_for_type(Fundamental::VictoryProgress::VICTORY_TYPE_ARTIFACTS)
        unless victory_progress.nil?
          victory_progress.decrement(:fulfillment_count)
          victory_progress.save
        end
      end
    end

    # propagates owner changes or initiation changes to victory progress of appropriate alliances
    def propagate_changes_to_victory_progress
      alliance_change  = self.changes[:alliance_id]
      initiated_change = self.changes[:initiated]
      initiated_before = initiated_change.nil? ? initiated : !initiated
      initiated_after  = initiated

      # if alliance changed
      unless alliance_change.nil?
        old_alliance = alliance_change[0].nil? ? nil : Fundamental::Alliance.find(alliance_change[0])
        new_alliance = alliance_change[1].nil? ? nil : Fundamental::Alliance.find(alliance_change[1])

        if initiated_before && !old_alliance.nil?
          # count bei der alten allianz runterzählen
          decrement_victory_progress(old_alliance)
        end
        if initiated_after && !new_alliance.nil?
          # count bei der neuen allianz hochzählen
          increment_victory_progress(new_alliance)
        end
      end

      # if only the initiation state changed
      if alliance_change.nil? && !initiated_change.nil? && !alliance.nil?
        if initiated_before
          # count bei der aktuellen allianz runterzählen
          decrement_victory_progress(alliance)
        end
        if initiated_after
          # count bei der aktuellen allianz hochzählen
          increment_victory_progress(alliance)
        end
      end
      true
    end

    def propagate_changes_to_character
      unless self.artifact_type[:experience_production].nil?
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
    end

    def add_character_resource_effect(owner_id, bonus)
      return if owner_id.nil?
      owner = Fundamental::Character.find_by_id(owner_id)
      return if owner.npc?
      owner.resource_pool.resource_effects.create({
        type_id:      Effect::ResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT,
        resource_id:  bonus[:resource_id],
        bonus:        bonus[:bonus],
        origin_id:    self.id,
      }) unless owner.nil?
    end

    def remove_character_resource_effect(bonus)
      self.character_resource_effects.where('resource_id = ?', bonus[:resource_id]).destroy_all
    end

    def add_alliance_resource_effect(alliance_id, bonus)
      return if alliance_id.nil?
      alliance = Fundamental::Alliance.find_by_id(alliance_id)
      alliance.resource_effects.create({
        type_id:      Effect::AllianceResourceEffect::RESOURCE_EFFECT_TYPE_ARTIFACT,
        resource_id:  bonus[:resource_id],
        bonus:        bonus[:bonus],
        origin_id:    self.id,
      }) unless alliance.nil?
    end

    def remove_alliance_resource_effect(bonus)
      self.alliance_resource_effects.where('resource_id = ?', bonus[:resource_id]).destroy_all
    end


    def add_character_construction_effect(owner_id, bonus)
      return if owner_id.nil?
      owner = Fundamental::Character.find_by_id(owner_id)
      return if owner.npc?
      owner.resource_pool.resource_effects.create({
        type_id:      Effect::ConstructionEffect::CONSTRUCTION_EFFECT_TYPE_ARTIFACT,
        bonus:        bonus[:bonus],
        origin_id:    self.id,
      }) unless owner.nil?
    end

    def remove_character_construction_effect
      self.character_resource_effects.destroy_all
    end

    def add_alliance_construction_effect(alliance_id, bonus)
      return if alliance_id.nil?
      alliance = Fundamental::Alliance.find_by_id(alliance_id)
      alliance.construction_effects.create({
         type_id:      Effect::AllianceConstructionEffect::CONSTRUCTION_EFFECT_TYPE_ARTIFACT,
         bonus:        bonus[:bonus],
         origin_id:    self.id,
       }) unless alliance.nil?
    end

    def remove_alliance_construction_effect
      self.alliance_resource_effects.destroy_all
    end

    def propagate_effect_changes
      unless self.artifact_type[:production_bonus].nil?
        owner_change     = self.changes[:owner_id]
        alliance_change  = self.changes[:alliance_id]

        initiated_change = self.changes[:initiated]
        initiated_before = initiated_change.nil? ? initiated : !initiated
        initiated_after  = initiated

        # if owner changed
        unless owner_change.nil?
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
        unless alliance_change.nil?
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
              add_character_resource_effect(owner_id, bonus)    if bonus[:domain_id] == 0
              add_alliance_resource_effect(alliance_id, bonus)  if bonus[:domain_id] == 2
            end
          end
        end
      end
      unless self.artifact_type[:construction_bonus].nil?
        owner_change     = self.changes[:owner_id]
        alliance_change  = self.changes[:alliance_id]

        initiated_change = self.changes[:initiated]
        initiated_before = initiated_change.nil? ? initiated : !initiated
        initiated_after  = initiated

        # if owner changed
        unless owner_change.nil?
          if initiated_before
            # effekt beim alten user löschen
            self.artifact_type[:construction_bonus].each do |bonus|
              remove_character_construction_effect if bonus[:domain_id] == 0
            end
          end
          if initiated_after
            # effekt beim neuen user eintragen
            self.artifact_type[:construction_bonus].each do |bonus|
              add_character_construction_effect(owner_change[1], bonus) if bonus[:domain_id] == 0
            end
          end
        end

        # if alliance changed
        unless alliance_change.nil?
          if initiated_before
            # effekt bei der alten allianz löschen
            self.artifact_type[:construction_bonus].each do |bonus|
              remove_alliance_construction_effect if bonus[:domain_id] == 2
            end
          end
          if initiated_after
            # effekt bei neuer allianz eintragen
            self.artifact_type[:construction_bonus].each do |bonus|
              add_alliance_construction_effect(alliance_change[1], bonus) if bonus[:domain_id] == 2
            end
          end
        end

        # if only the initiation state changed
        if owner_change.nil? && alliance_change.nil? && !initiated_change.nil?
          if initiated_before
            # effekt beim aktuellen user_loeschen
            self.artifact_type[:construction_bonus].each do |bonus|
              remove_character_construction_effect if bonus[:domain_id] == 0
              remove_alliance_construction_effect  if bonus[:domain_id] == 2
            end
          end
          if initiated_after
            # effekt beim aktuellen user eintragen
            self.artifact_type[:construction_bonus].each do |bonus|
              add_character_construction_effect(owner_id, bonus)    if bonus[:domain_id] == 0
              add_alliance_construction_effect(alliance_id, bonus)  if bonus[:domain_id] == 2
            end
          end
        end
      end
      true
    end
end
