class Settlement::Settlement < ActiveRecord::Base

  belongs_to :owner,    :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  belongs_to :founder,  :class_name => "Fundamental::Character", :foreign_key => "founder_id"  
  belongs_to :alliance, :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"  
  belongs_to :location, :class_name => "Map::Location",          :foreign_key => "location_id",        :inverse_of => :settlement  
  belongs_to :region,   :class_name => "Map::Region",            :foreign_key => "region_id",          :inverse_of => :settlements 
  
  has_many   :slots,    :class_name => "Settlement::Slot",       :foreign_key => "settlement_id",      :inverse_of => :settlement
  has_many   :armies,   :class_name => "Military::Army",         :foreign_key => "home_settlement_id", :inverse_of => :home
  has_many   :queues,   :class_name => "Construction::Queue",    :foreign_key => "settlement_id",      :inverse_of => :settlement
  has_many   :training_queues,   :class_name => "Training::Queue",    :foreign_key => "settlement_id",      :inverse_of => :settlement
  
  attr_readable :id, :type_id, :region_id, :location_id, :node_id, :owner_id, :alliance_id, :level, :foundet_at, :founder_id, :owns_region, :taxable, :garrison_id, :besieged, :created_at, :updated_at, :points, :as => :default 
  attr_readable *readable_attributes(:default), :defense_bonus, :morale,                   :as => :ally 
  attr_readable *readable_attributes(:ally),    :tax_rate, :command_points, :armies_count, :as => :owner
  attr_readable *readable_attributes(:owner),                                              :as => :staff
  attr_readable *readable_attributes(:staff),                                              :as => :admin

  after_initialize :init
  
  before_save :manage_queues_as_needed
  before_save :update_resource_production

  after_save  :propagate_changes_to_resource_pool  
  after_save  :propagate_information_to_region
  after_save  :propagate_information_to_location

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
  

  
  ############################################################################
  #
  #  RESOURCES AND RESOURCE PRODUCTION 
  #
  ############################################################################   
  
  # recalculate the production rate for all resource types on basis of the 
  # present base production and the production boni from buildings, 
  # sciences etc..
  def update_resource_production
    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      base = resource_type[:symbolic_id].to_s
      update_resource_production_bonus(base)
      update_resource_production_rate(base)
    end
    true
  end  
  
  ############################################################################
  #
  #  MANAGING QUEUES 
  #
  ############################################################################  
  
  def create_queue(queue_type)
    if queue_type[:category]    == :queue_category_construction
      create_construction_queue(queue_type)
    elsif queue_type[:category] == :queue_category_training
      create_training_queue(queue_type)
    elsif queue_type[:category] == :queue_category_research
      logger.error "Creation of queue type #{queue_type[:category]} not yet implemented."
    else
      logger.error "Could not create queue of unkown type #{queue_type[:category]}."
    end
  end
  
  def destroy_queue(queue_type)
    raise InternalServerError.new('Could not destroy queue because there is none.') if self.queues.nil?
    self.queues.each do |queue|
      if queue[:type_id] == queue_type[:id]
        queue.destroy
        return    # return immediately, just one queue of this tpye
      end
    end
  end
  
  # creates a construction queue and sets its parameters properly.
  def create_construction_queue(queue_type)
    self.queues.create({
      :type_id    => queue_type[:id], 
      :threads    => queue_type[:base_threads],
      :max_length => queue_type[:base_slots],      
    })  
  end
  
  # creates a training queue and sets its parameters properly.
  # TOOD: add parameters, as soon as queue available.
  def create_training_queue(queue_type)
    self.training_queues.create({
      :type_id    => queue_type[:id], 
      # add queue-specific parameters here
    })  
  end


  def propagate_speedup_to_queue(origin_type, queue_type_id, delta)
    queue = self.queues.where("type_id = ?", queue_type_id).first
    raise InternalServerError.new('Could not find queue of type #{queue_type_id}') if queue.nil?
    queue.add_speedup(origin_type, delta)
    queue.save
    true
  end
  

  protected
  
    ############################################################################
    #
    #  UPDATING PRODUCTION QUEUES 
    #
    ############################################################################     
  
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
    
    ############################################################################
    #
    #  UPDATING RESOURCE PRODUCTION 
    #
    ############################################################################    
    
    def update_resource_production_bonus(base)
      sum = self[base+"_production_bonus_buildings"] + self[base+"_production_bonus_sciences"] + self[base+"_production_bonus_alliance"] + self[base+"_production_bonus_effects"]
      self[base+"_production_bonus"] = sum
      true
    end
        
    def update_resource_production_rate(base)
      sum = self[base+"_production_bonus_buildings"] + self[base+"_production_bonus_sciences"] + self[base+"_production_bonus_alliance"] + self[base+"_production_bonus_effects"]       
      self[base+"_production_rate"] = self[base+"_base_production"]  * (1.0 + self[base+"_production_bonus"])
      true
    end
    
    
    ############################################################################
    #
    #  SPREADING LOCAL CHANGES TO RELATED MODELS 
    #
    #########################################################################
    
    
    # propagates local changes to the location, where some fields are mirrored
    # for performance reasons.
    def propagate_information_to_location
      if (self.owner_id_changed? || self.alliance_id_changed? || self.level_changed? || self.type_id_changed?) && !self.location.nil?
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
      if (self.owner_id_changed? || self.alliance_id_changed? || self.level_changed? || self.type_id_changed?) && self.owns_region? && !self.region.nil?
        self.region.set_owner_and_alliance(owner_id, alliance_id)
        self.region.settlement_level   = self.level     if (self.region.settlement_level   != self.level)
        self.region.settlement_type_id = self.type_id   if (self.region.settlement_type_id != self.type_id) 
        self.region.save
      end
      return true
    end
    
    
    def propagate_changes_to_resource_pool
      if self.owner_id_changed?
        propagate_changes_to_resource_pool_on_changed_possesion
      elsif (!self.owner_id.nil? && self.owner_id > 0)         # only spread, if there's a resource pool
        changed = false
        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          attribute = resource_type[:symbolic_id].to_s()+'_production_rate'
          if !self.changes[attribute].nil?
            changed = true
            change = self.changes[attribute]
            delta = change[1] - change[0]   # new - old value
            self.owner.resource_pool[attribute] = self.owner.resource_pool[attribute] + delta
          end
        end
        self.owner.resource_pool.save if changed  # only load character and resource pool, iff there hase been a change!
      end
      
      true
    end
    
    # this case (owner changed) is a little bit more tricky; bascially,
    # we need to remove resource produciton from the old owner's pool 
    # and add it to the new owner's pool. But unfortunately, at the
    # same time, the rate might have changed (e.g. due to different
    # science boni). Thus, we need to remove the old production value 
    # from the old pool and add the new production value to the new
    # pool.
    #
    # Function can handle one or both owners being nil.
    def propagate_changes_to_resource_pool_on_changed_possesion
      owner_change = self.changes[:owner_id]
      if !owner_change.blank?
        old_owner = owner_change[0].nil? ? nil : Fundamental::Character.find_by_id(owner_change[0])
        new_owner = owner_change[1].nil? ? nil : Fundamental::Character.find_by_id(owner_change[1])

        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          attribute = resource_type[:symbolic_id].to_s()+'_production_rate'
          old_value = self[attribute]
          new_value = self[attribute]
          if !self.changes[attribute].nil?
            prod_change = self.changes[attribute]
            new_value = change[1] 
            old_value = change[0]   
          end
          
          old_owner.resource_pool[attribute] = (old_owner.resource_pool[attribute] || 0.0) + old_value   unless old_owner.nil?
          new_owner.resource_pool[attribute] = (new_owner.resource_pool[attribute] || 0.0) + new_value   unless new_owner.nil? 
        end

        old_owner.resource_pool.save   unless old_owner.nil?
        new_owner.resource_pool.save   unless new_owner.nil?
      end
      true
    end
    

end
