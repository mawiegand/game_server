require 'util'

class Map::Region < ActiveRecord::Base
  
  belongs_to :node,            :class_name => "Node",                   :foreign_key => "node_id"
  belongs_to :alliance,        :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"  
  belongs_to :owner,           :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  
  has_many :locations,         :class_name => "Location",               :foreign_key => "region_id",   :inverse_of => :region, :order => :slot,        :dependent => :destroy
  has_one  :fortress_location, :class_name => "Location",               :foreign_key => "region_id",   :inverse_of => :region, :conditions => 'slot = 0'
  has_one  :fortress,          :class_name => "Settlement::Settlement", :foreign_key => "region_id",   :inverse_of => :region, :conditions => ['owns_region = ?', true]
  has_many :settlements,       :class_name => "Settlement::Settlement", :foreign_key => 'region_id',   :inverse_of => :region
  has_many :armies,            :class_name => "Military::Army",         :foreign_key => "region_id",   :inverse_of => :region
  
  has_many :battles,           :class_name => "Military::Battle",       :inverse_of => :region

  has_many  :artifacts,        :class_name => "Fundamental::Artifact",  :foreign_key => "region_id",   :inverse_of => :region
  
  before_create :add_unique_invitation_code
  
  before_save   :prevent_empty_moving_password

  after_create  :propagate_regions_count_to_round_info
  after_destroy :propagate_regions_count_to_round_info
  
  scope :non_occupied, where(owner_id: 1)

  def recount_settlements
    self.count_settlements = self.locations.where('settlement_type_id = 2').count
    self.save
  end

  def non_fortress_locations_owned_by(character)
    self.locations.owned_by(character).excluding_fortress_slots
  end

  def owned_by_npc?
    self.owner_id == 1
  end

  def settleable_by?(character)
    non_fortress_locations_owned_by(character).count == 0 && self.locations.empty.count > 0
  end

  def takeoverable_by?(character)
    non_fortress_locations_owned_by(character).count == 0
  end

  def owned_by_alliance?(alliance)
    self.alliance == alliance and !self.alliance.nil?
  end
  
  def check_moving_password?(moving_password)
    self.moving_password == moving_password
  end
  
  def is_moving_allowed?(alliance, moving_password)
    self.owned_by_npc? || self.owned_by_alliance?(alliance) || check_moving_password?(moving_password)
  end
  
	def last_takeover_at
		self.fortress.last_takeover_at
	end

  def find_empty_location
    free_locations = self.locations.empty.count
    self.locations.empty.offset(Random.rand(free_locations)).first
  end

  def set_special_image(owner)
    if !owner.image_set_id.nil?
      self.image_id = owner.image_set_id
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
  
  def add_unique_invitation_code
    begin
      self.invitation_code = Util.make_random_string(16, true)
    end while !Map::Region.find_by_invitation_code(self.invitation_code).nil?
  end
  
  def self.find_by_id_or_name(region_identifier)
    region = Map::Region.find_by_id(region_identifier) if Map::Region.valid_id?(region_identifier)
    region = Map::Region.find_by_name(region_identifier) if region.nil?
    region
  end

  def check_and_repair_name
    if self.fortress.name != self.name
      logger.warn(">>>ARMY NAME DIFFERS. Old: #{self.name} Corrected: #{self.fortress.name}.")
      self.name = self.fortress.name
    end
  end
  
  def check_consistency
    check_and_repair_name

    if self.changed?
      logger.info(">>> SAVING REGION AFTER DETECTING ERRORS.")
      self.save
    else
      logger.info(">>> REGION OK.")
    end

    true
  end

  private
    def self.valid_id?(id)
      id.index(/^[1-9]\d*$/) != nil
    end
  
    def propagate_regions_count_to_round_info
      info = Fundamental::RoundInfo.the_round_info
      info.regions_count = Map::Region.count
      info.save
    end  
    
    def prevent_empty_moving_password
      if self.moving_password.nil?
        self.moving_password = Util.make_random_string(6)
      end
      true
    end
end
