class Settlement::Settlement < ActiveRecord::Base

  belongs_to :owner,    :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  belongs_to :founder,  :class_name => "Fundamental::Character", :foreign_key => "founder_id"  
  belongs_to :alliance, :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"  
  belongs_to :location, :class_name => "Map::Location",          :foreign_key => "location_id",        :inverse_of => :settlement  
  belongs_to :region,   :class_name => "Map::Region",            :foreign_key => "region_id",          :inverse_of => :settlements 
  
  has_many   :slots,    :class_name => "Settlement::Slot",       :foreign_key => "settlement_id",      :inverse_of => :settlement
  has_many   :armies,   :class_name => "Military::Army",         :foreign_key => "home_settlement_id", :inverse_of => :home
  has_many   :queues,   :class_name => "Construction::Queue",    :foreign_key => "settlement_id",      :inverse_of => :settlement
  
  attr_readable :id, :type_id, :region_id, :location_id, :node_id, :owner_id, :alliance_id, :level, :foundet_at, :founder_id, :owns_region, :taxable, :garrison_id, :besieged, :created_at, :updated_at, :points, :as => :default 
  attr_readable *readable_attributes(:default), :defense_bonus, :morale,                   :as => :ally 
  attr_readable *readable_attributes(:ally),    :tax_rate, :command_points, :armies_count, :as => :owner
  attr_readable *readable_attributes(:owner),                                              :as => :staff
  attr_readable *readable_attributes(:staff),                                              :as => :admin

  after_initialize :init
  
  before_save :manage_queues_as_needed
  
  after_save :propagate_information_to_region
  after_save :propagate_information_to_location
  

  def self.create_settlement_at_location(location, type_id, owner)
    raise BadRequestError.new('Tried to create a settlement at a non-empty location.') unless location.settlement.nil?
    
    location.create_settlement({
      :region_id   => location.region_id,
      :node_id     => location.region.node_id,
      :type_id     => type_id,
      :level       => 1,                           # start with level 1
      :founded_at  => DateTime.now,
      :founder_id  => owner.id,
      :owner_id    => owner.id,
      :alliance_id => owner.alliance_id,
      :owns_region => type_id == 1,  # fortress?
    })
    location.settlement.create_building_slots_according_to(GameRules::Rules.the_rules.settlement_types[type_id][:building_slots]) 
  end
  
  # set default values in an after_initialize handler. 
  def init
    level         ||= 1
    defense_bonus = 0     if defense_bonus.nil?
    morale        = 1.0   if morale.nil?
    tax_rate      = 0.1   if tax_rate.nil? && owns_region
    taxable       = !owns_region
    command_points= 0     if command_points.nil?
    besieged      = false if besieged.nil?
    points        = 0     if points.nil?
  end
  
  # creates building slotes for the present settlements according to the given
  # spec. The spec is an array of building options. Usually, you would like to
  # pass the corresponding array from the game rules to this method.
  def create_building_slots_according_to(spec)
    spec.each do |number, details|
      slot = self.slots.create({
        :slot_num => number,
      })
      
      if !details[:building].blank?
        slot.create_building(details[:building]);
        logger.debug "Created building with id #{details[:building]} in slot #{slot.inspect}."
        
        if !details[:level].blank? 
          while slot.level < details[:level]
            slot.upgrade_building
          end
        end
      end
    end
  end
  
  def create_queue(queue_type)
    if queue_type[:category]    == :queue_category_construction
      create_construction_queue(queue_type)
    elsif queue_type[:category] == :queue_category_training
      logger.error "Creation of queue type #{queue_type[:category]} not yet implemented."
    elsif queue_type[:category] == :queue_category_research
      logger.error "Creation of queue type #{queue_type[:category]} not yet implemented."
    else
      logger.error "Could not create queue of unkown type #{queue_type[:category]}."
    end
  end
  
  def destroy_queue(queue_type)
    if queue_type[:category]    == :queue_category_construction
      destroy_construction_queue(queue_type)
    elsif queue_type[:category] == :queue_category_training
      logger.error "Destruction of queue type #{queue_type[:category]} not yet implemented."
    elsif queue_type[:category] == :queue_category_research
      logger.error "Destruction of queue type #{queue_type[:category]} not yet implemented."
    else
      logger.error "Could not destroy queue of unkown type #{queue_type[:category]}."
    end
  end
  
  def create_construction_queue(queue_type)
    self.queues.create({
      :type_id    => queue_type[:id], 
      :threads    => queue_type[:base_threads],
      :max_length => queue_type[:base_slots],      
    })  
  end
  
  def destroy_construction_queue(queue_type)
    raise InternalServerError.new('Could not destroy construction queue because there is none.') if self.queues.nil?
    self.queues.each do |queue|
      if queue[:type_id] == queue_type[:id]
        queue.destroy
        return    # return immediately, just one queue of this tpye
      end
    end
  end
  
  def propagate_speedup_to_queue(origin_type, queue_type_id, delta)
    queue = self.queues.where("type_id = ?", queue_type_id).first
    raise InternalServerError.new('Could not find queue of type #{queue_type_id}') if queue.nil?
    queue.add_speedup(origin_type, delta)
    queue.save
  end

  
  protected
  
    # propagates local changes to the location, where some fields are mirrored
    # for performance reasons.
    def propagate_information_to_location
      if !self.location.nil?
        self.location.set_owner_and_alliance(owner_id, alliance_id)
        self.location.settlement_level   = self.level   if (self.location.settlement_level   != self.level)
        self.location.settlement_type_id = self.type_id if (self.location.settlement_type_id != self.type_id)
        self.location.save
      end
      return true
    end
  
    # propagates local changes to the region, where some fields are mirrored
    # for performance reasons.
    def propagate_information_to_region
      if self.owns_region? && !self.region.nil?
        self.region.set_owner_and_alliance(owner_id, alliance_id)
        self.region.settlement_level   = self.level     if (self.region.settlement_level   != self.level)
        self.region.settlement_type_id = self.type_id   if (self.region.settlement_type_id != self.type_id) 
        self.region.save
      end
      return true
    end
  
    def manage_queues_as_needed
      if self.changed?
        queue_types = GameRules::Rules.the_rules().queue_types
      
        changes.each do | attribute, change |           # iterate through all changed attributes
          queue_types.each do |queue|                   # must test it against every queue
            if queue[:domain] == :settlement && queue[:unlock_field] == attribute.to_sym # to check, whether fields match :-(
              if change[0] == 0 && change[1] >= 1       # updated from 0 to >=1 -> unlock!   
                create_queue(queue)
              elsif change[0] >= 1 && change[1] == 0    # updaetd from >=1 to 0 -> lock!
                destroy_queue(queue)
              end
            end
          end
        end
      end
      return true
    end
    
    

end
