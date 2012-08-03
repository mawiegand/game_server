class Settlement::Settlement < ActiveRecord::Base
  
  belongs_to :owner,    :class_name => "Fundamental::Character", :foreign_key => "owner_id"  
  belongs_to :founder,  :class_name => "Fundamental::Character", :foreign_key => "founder_id"  
  belongs_to :alliance, :class_name => "Fundamental::Alliance",  :foreign_key => "alliance_id"  
  belongs_to :location, :class_name => "Map::Location",          :foreign_key => "location_id",        :inverse_of => :settlement  
  belongs_to :region,   :class_name => "Map::Region",            :foreign_key => "region_id",          :inverse_of => :settlements 
  belongs_to :garrison_army,   :class_name => "Military::Army",  :foreign_key => "garrison_id"
  
  has_many   :slots,    :class_name => "Settlement::Slot",       :foreign_key => "settlement_id",      :inverse_of => :settlement
  has_many   :armies,   :class_name => "Military::Army",         :foreign_key => "home_settlement_id", :inverse_of => :home
  has_many   :queues,   :class_name => "Construction::Queue",    :foreign_key => "settlement_id",      :inverse_of => :settlement
  has_many   :training_queues, :class_name => "Training::Queue", :foreign_key => "settlement_id",      :inverse_of => :settlement
  
  
  attr_readable :id, :type_id, :region_id, :location_id, :node_id, :owner_id, :alliance_id, :level, :foundet_at, :founder_id, :owns_region, :taxable, :garrison_id, :besieged, :created_at, :updated_at, :points, :as => :default 
  attr_readable *readable_attributes(:default), :defense_bonus, :morale,                               :as => :ally 
  attr_readable *readable_attributes(:ally),    :tax_rate, :command_points, :garrison_size_max, :army_size_max, :armies_count, :resource_, :as => :owner
  attr_readable *readable_attributes(:owner),                                                          :as => :staff
  attr_readable *readable_attributes(:staff),                                                          :as => :admin

  after_initialize :init
  
  before_save :manage_queues_as_needed
  before_save :update_resource_bonus_on_owner_change  # obtains the global boni (alliance, sciences, effects) from the resource pool
  before_save :update_resource_production             # recalculates the production rates on basis of the base_productions and production_bonus

  after_save  :propagate_changes_to_resource_pool     # does nothing on owner change
  after_save  :propagate_score_changes                # does nothing on owner change
  after_save  :propagate_unlock_changes               # does nothing on owner change  
  after_save  :propagate_owner_changes                # corrects resource production, ranking scores, and unlock_counts on owner change
  after_save  :propagate_information_to_region
  after_save  :propagate_information_to_location
  after_save  :propagate_information_to_armies
  after_save  :propagate_information_to_garrison

  def empire_unlock_fields 
    [ { attrl: :settlement_unlock_alliance_creation_count, attrc: :character_unlock_alliance_creation_count },
      { attrl: :settlement_unlock_diplomacy_count,         attrc: :character_unlock_diplomacy_count },
    ]
  end
  
  def alliance_unlock_fields 
    []
  end  


  def self.create_settlement_at_location(location, type_id, owner)
    raise BadRequestError.new('Tried to create a settlement at a non-empty location.') unless location.settlement.nil?
    
    settlement = location.create_settlement({
      :region_id   => location.region_id,
      :node_id     => location.region.node_id,
      :type_id     => type_id,
      :level       => 0,                           # new: start with level 0
      :founded_at  => DateTime.now,
      :founder_id  => owner.id,
      :owner_id    => owner.id,
      :alliance_id => owner.alliance_id,
      :alliance_tag=> owner.alliance_tag,
      :owns_region => type_id == 1,  # fortress?
    })
    Military::Army.create_garrison_at(settlement)
    settlement.create_building_slots_according_to(GameRules::Rules.the_rules.settlement_types[type_id][:building_slots]) 
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
    level             ||= 1
    defense_bonus     = 0     if defense_bonus.nil?
    morale            = 1.0   if morale.nil?
    tax_rate          = 0.1   if tax_rate.nil? && owns_region
    taxable           = !owns_region
    command_points    = 0     if command_points.nil?
    besieged          = false if besieged.nil?
    points            = 0     if points.nil?
    garrison_size_max = 0     if garrison_size_max.nil?
    army_size_max     = 0     if army_size_max.nil?
  end
  

  ############################################################################
  #
  #  OWNERSHIP 
  #
  ############################################################################   

  def owned_by_npc?
    return self.owner.nil? || self.owner.npc?
  end
  
  def new_owner_transaction(character)
    # settlement BLOCK
    logger.info "NEW OWNER TRANSACTION starting on settlement ID#{ self.id } from character #{ self.owner_id } to #{ character.nil? ? "nil" : character.id }."
    
    old_owner = self.garrison_army.npc ? nil : self.garrison_army.owner
    
    self.garrison_army.destroy        unless self.garrison_army.nil?
    self.armies.destroy_all           unless self.armies.nil?         # destroy (vs delete), because should run through callbacks

    self.owner        = character
    self.alliance_id  = character.alliance_id
    self.alliance_tag = character.alliance_tag
    
    Military::Army.create_garrison_at(self)
    self.save                         # triggers before_save and after_save handlers that do all the work
    
    # settlement UNBLOCK
  end

  ############################################################################
  #
  #  ARMIES
  #
  ############################################################################   
    
  def command_points_available?
    !self.command_points.nil? && self.command_points > (self.armies_count-1)  # don't count garrison army 
  end
  
  ############################################################################
  #
  #  BATTLE
  #
  ############################################################################   
    
  def can_be_taken_over?
    #TODO define in the rules
    #get the base
    base_type = nil
    GameRules::Rules.the_rules.settlement_types.each do |t|
      if t[:symbolic_id] == :settlement_home_base
        base_type = t
      end
    end
    raise InternalServerError.new('base_type not found in the rules') if base_type.nil?
    (self.type_id != base_type[:id])
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

  def update_resource_bonus_on_owner_change
    owner_change = self.changes[:owner_id]
    if !owner_change.blank?
      logger.info 'Running resource bonus owner-change handler on settlement ID#{self.id}.'
      pool = owner_change[1].blank? ? nil : Fundamental::ResourcePool.find_by_character_id(owner_change[1])  # the pool of the new owner or nil
      
      GameRules::Rules.the_rules().resource_types.each do |resource_type|
        base = resource_type[:symbolic_id].to_s
        obtain_global_resource_production_bonus(base, pool)
      end      
    end
    true
  end
  
  def check_consistency_sometimes
    return         unless rand(100) / 100.0 < GAME_SERVER_CONFIG['settlement_recalc_probability']       # do the check only seldomly (determined by random event)  
    check_consistency
  end
  
  # unfortunately, this cannot be an after_commit handler, because at that point
  # the slot, that triggered the transaction on the settlement has not ended its
  # own transaction, thus, is not visible when selecting it from the database.
  # therefore the recalculation is triggered from an after commit handler from the
  # slot. unfortunately, changes therefore cannot be detected in this method; the
  # recalculation is triggered independently of whether or not resource attributes
  # have been changed.
  def check_consistency
    logger.info(">>> COMPLETE RECALC of RESOURCE PRODUCTION in settlement #{self.id}: #{self.name} of character #{self.owner_id}.")

    productions = recalc_resource_production_base
    check_and_apply_productions(productions)
    
    boni = recalc_local_resource_production_boni
    check_and_apply_local_resource_production_boni(boni)
    
    unlocks = recalc_queue_unlocks
    check_and_apply_queue_unlocks(unlocks)

    speedups = recalc_queue_speedups
    check_and_apply_queue_speedups(speedups)

    n_command_points = recalc_command_points
    check_and_apply_command_points(n_command_points)

    n_garrison_size_max = recalc_garrison_size_max
    check_and_apply_garrison_size_max(n_garrison_size_max)

    n_army_size_max = recalc_army_size_max
    check_and_apply_army_size_max(n_army_size_max)

    if self.changed?
      logger.info(">>> SAVING SETTLEMENT AFTER DETECTING ERRORS.")
      self.save
    else
      logger.info(">>> SETTLEMENT OK.")
    end
    
    true      
  end

  
  def resource_production_changed?
    changed = false
    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      base = resource_type[:symbolic_id].to_s
      changed ||= !self.changes[base+'_production_rate'].nil?
    end
    return changed
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
    queues = []
    
    if    queue_type[:category] == :queue_category_construction
      queues = self.queues
    elsif queue_type[:category] == :queue_category_training
      queues = self.training_queues
    elsif queue_type[:category] == :queue_category_research
      logger.error "Deletion of queue type #{queue_type[:category]} not yet implemented."
    else
      logger.error "Could not delete queue of unkown type #{queue_type[:category]}."
    end
    
    raise InternalServerError.new('Could not destroy queue because there is none.') if self.queues.nil?
    queues.each do |queue|
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
      :threads    => queue_type[:base_threads],
      :max_length => queue_type[:base_slots],      
    })  
  end


  def propagate_speedup_to_queue(origin_type, queue_type, delta)
    queue = nil
    
    if    queue_type[:category] == :queue_category_construction
      queue = self.queues.where("type_id = ?", queue_type[:id]).first
    elsif queue_type[:category] == :queue_category_training
      queue = self.training_queues.where("type_id = ?", queue_type[:id]).first
    elsif queue_type[:category] == :queue_category_research
      logger.error "Speedup for queue type #{queue_type[:category]} not yet implemented."
    else
      logger.error "Could not speed up queue of unkown type #{queue_type[:category]}."
    end
    
    raise InternalServerError.new('Could not find queue of type #{queue_type_id}') if queue.nil?
    queue.add_speedup(origin_type, delta)
    queue.save
    true
  end
  
  def add_units_to_garrison(unit_id, quantity)
    # create garrison army if it not exists
    army = self.garrison_army
    unit_types = GameRules::Rules.the_rules().unit_types
    army.details.increment(unit_types[unit_id][:db_field], quantity)
    army.details.save
  end

  protected
  
    ############################################################################
    #
    #  UPDATING ABILITIES  
    #
    ############################################################################     
    
    def recalc_command_points
      cp = 0
      self.slots.each do |slot|
        cp += slot.command_points
      end
      cp    
    end
    
    def check_and_apply_command_points(cp)
      if (self.command_points != cp) 
        logger.warn(">>> COMMAND POINTS RECALC DIFFERS. Old: #{self.command_points} Corrected: #{cp}.")
        self.command_points = cp
      end
    end
  
    def recalc_army_size_max
      army_size = 0
      self.slots.each do |slot|
        army_size += slot.army_size_bonus
      end
      army_size    
    end
    
    def check_and_apply_army_size_max(as)
      if self.army_size_max != as 
        logger.warn(">>> ARMY SIZE MAX RECALC DIFFERS. Old: #{self.army_size_max} Corrected: #{as}.")
        self.army_size_max = as
      end
    end
  
    def recalc_garrison_size_max
      garrison_size = 0
      self.slots.each do |slot|
        garrison_size += slot.garrison_size_bonus
      end
      garrison_size    
    end
    
    def check_and_apply_garrison_size_max(gs)
      if (self.garrison_size_max != gs) 
        logger.warn(">>> GARRISON SIZE MAX RECALC DIFFERS. Old: #{self.garrison_size_max} Corrected: #{gs}.")
        self.garrison_size_max = gs
      end
    end
  
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
    

    
    
    def recalc_queue_unlocks
      queue_types = GameRules::Rules.the_rules().queue_types
      unlocks     = Array.new(queue_types.count, 0)

      self.slots.each do |slot|
        slot.queue_unlocks(unlocks)
      end
      unlocks
    end
    
    def check_and_apply_queue_unlocks(unlocks)
      GameRules::Rules.the_rules().queue_types.each do |queue|
        if queue[:domain] == :settlement
          present = self[queue[:unlock_field]]
          recalc  = unlocks[queue[:id]]
        
          if (present != recalc)
            logger.warn(">>> QUEUE UNLOCK RECALC DIFFERS for #{queue[:name][:en_US]}. Old: #{present} Corrected: #{recalc}.")
            self[queue[:unlock_field]] = recalc
          end
        end
      end  
    end
    
    def recalc_queue_speedups
      queue_types = GameRules::Rules.the_rules().queue_types
      speedups    = Array.new(queue_types.count, 0.0)

      self.slots.each do |slot|
        slot.queue_speedups(speedups)
      end
      speedups
    end
    
    def check_and_apply_queue_speedups(speedups)
      GameRules::Rules.the_rules().queue_types.each do |queue_type|
        logger.debug(queue_type.inspect)
        if queue_type[:domain] == :settlement && !self[queue_type[:unlock_field]].nil? && self[queue_type[:unlock_field]] >= 1   # queue is available
          queue = nil
          
          if (queue_type[:category] == :queue_category_construction)
            queue = Construction::Queue.find_by_settlement_id_and_type_id(self.id, queue_type[:id])
          elsif (queue_type[:category] == :queue_category_training)
            queue = Training::Queue.find_by_settlement_id_and_type_id(self.id, queue_type[:id])
          else
            logger.warn "UNKNOWN QUEUE TYPE in recalculation of queue speedups."
          end
          
          if queue.nil?
            logger.error "HAVE NOT FOUND A QUEUE for queue type #{ queue_type[:symbolic_id] } in settlement #{ self.id } with unlock count #{ self[queue_type[:unlock_field]] }."
          else            
            present = queue.speedup_buildings
            recalc  = speedups[queue_type[:id]]        
        
            if (present != recalc)
              logger.warn(">>> QUEUE SPEEDUP RECALC DIFFERS for #{queue_type[:name][:en_US]}. Old: #{present} Corrected: #{recalc}.")
              queue.speedup_buildings = recalc
              logger.info(">>> SAVING QUEUE AFTER DETECTING ERRORS.")
              queue.save
            end
          end
        end
      end  
    end
    
    ############################################################################
    #
    #  UPDATING RESOURCE PRODUCTION 
    #
    ############################################################################    
    
    # fetches the global resource boni for one resource (base) comming from the
    # alliance, sciences and global effects from the pool and sets the 
    # settlement accordingly
    def obtain_global_resource_production_bonus(base, pool)
      self[base+"_production_bonus_alliance"]       = pool ? pool[base+"_production_bonus_alliance"] : 0;
      self[base+"_production_bonus_sciences"]       = pool ? pool[base+"_production_bonus_sciences"] : 0;
      self[base+"_production_bonus_global_effects"] = pool ? pool[base+"_production_bonus_effects"]  : 0;
    end   
    
    # accumulates the individual boni and stores the results in the 
    # _production_bonus fields
    def update_resource_production_bonus(base)
      sum = (self[base+"_production_bonus_buildings"] || 0) + (self[base+"_production_bonus_sciences"] || 0) + (self[base+"_production_bonus_alliance"] || 0) + (self[base+"_production_bonus_effects"] || 0)  + (self[base+"_production_bonus_global_effects"] || 0) 
      self[base+"_production_bonus"] = sum
      true
    end
       
    # recaclucates and sets the present production rate according to the present
    # base production and the boni according to rate = base * (1+bonus) .    
    def update_resource_production_rate(base)
      self[base+"_production_rate"] = self[base+"_base_production"]  * (1.0 + self[base+"_production_bonus"])
      true
    end
    

    
    def recalc_resource_production_base
      resource_types = GameRules::Rules.the_rules().resource_types
      productions    = Array.new(resource_types.count, 0)
      self.slots.each do |slot|
        slot.resource_production(productions)
      end
      return productions
    end
    
    def check_and_apply_productions(productions)
      GameRules::Rules.the_rules().resource_types.each do |resource_type|
        base = resource_type[:symbolic_id].to_s
        present = self[base+'_base_production']
        recalc  = productions[resource_type[:id]]
        
        if (present != recalc)
          logger.warn(">>> BASE RATE RECALC DIFFERS for #{resource_type[:name][:en_US]}. Old: #{present} Corrected: #{recalc}.")
          self[base+'_base_production'] = recalc
        end
      end    
    end
    
    
    
    def recalc_local_resource_production_boni
      resource_types = GameRules::Rules.the_rules().resource_types
      boni           = Array.new(resource_types.count, 0)
      self.slots.each do |slot|
        slot.production_bonus(boni)
      end
      return boni
    end
    
    def check_and_apply_local_resource_production_boni(boni)
      GameRules::Rules.the_rules().resource_types.each do |resource_type|
        base = resource_type[:symbolic_id].to_s
        present = self[base+'_production_bonus_buildings']
        recalc  = boni[resource_type[:id]]
        
        if (present != recalc)
          logger.warn(">>> BUILDING BONUS RECALC DIFFERS for #{resource_type[:name][:en_US]}. Old: #{present} Corrected: #{recalc}.")
          self[base+'_production_bonus_buildings'] = recalc
        end
      end    
    end
    
    ############################################################################
    #
    #  SPREADING LOCAL CHANGES TO RELATED MODELS (AFTER SAVE)
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
      return true    if self.owner_id_changed?                 # will be handled by a different after-save handler
      if (!self.owner_id.nil? && self.owner_id > 0)            # only spread, if there's a resource pool
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
        self.owner.resource_pool.save if changed  # only save character and resource pool, if there hase been a change!
      end
      
      true
    end
    
    def propagate_score_changes
      return true    if self.owner_id_changed?                 # will be handled by a different after-save handler
      if (!self.owner_id.nil? && self.owner_id > 0)            # only spread, if there's a resource pool
        score_change = self.changes[:score] 
        if !score_change.nil? && self.owner
          self.owner.score = (self.owner.score || 0) + (score_change[1] || 0) - (score_change[0] || 0) 
          self.owner.save
        end
      end
      true 
    end
    
    
    def propagate_unlock_changes
      return true    if self.owner_id_changed?                 # will be handled by a different after-save handler
      propagate_unlock_changes_to_model(self.owner, empire_unlock_fields)       unless self.owner_id.nil?    || self.owner_id == 0
      propagate_unlock_changes_to_model(self.alliance, alliance_unlock_fields)  unless self.alliance_id.nil? || self.alliance_id == 0
      true
    end
    
    def propagate_unlock_changes_to_model(model, fields)
      changes = fields.select { |entry| !self.changes[entry[:attrl]].nil? }
      if changes.length > 0
        changes.each do |entry| 
          change = self.changes[entry[:attrl]]
          logger.debug(change)
          model.increment(entry[:attrc], (change[1] || 0) - (change[0] || 0))
        end
        model.save
      end
      true
    end
    
    def propagate_information_to_armies
      # :armies
      self.armies.each do |army|
        if !army.garrison
          army.size_max = self.army_size_max
          army.save
        end
      end
    end
    
    def propagate_information_to_garrison
      self.garrison_army.size_max = self.garrison_size_max
      self.garrison_army.save
    end
    
    ##########################################################################
    #
    #  SPREADING A CHANGE OF OWNERSHIP TO RELATED MODELS  (AFTER_SAVE)
    #
    ##########################################################################
    
    def propagate_owner_changes    
      owner_change = self.changes[:owner_id]
      if !owner_change.nil?
        propagate_changes_to_resource_pool_on_changed_possession
        propagate_score_on_changed_possession
        propagate_unlock_changes_on_changed_possession
      end
      true
    end
             
    def propagate_unlock_changes_on_changed_possession
      owner_change = self.changes[:owner_id]
      if !owner_change.blank?
        # propagate fields to character
        old_owner = owner_change[0].nil? ? nil : Fundamental::Character.find_by_id(owner_change[0])
        new_owner = owner_change[1].nil? ? nil : Fundamental::Character.find_by_id(owner_change[1])
        propagate_unlock_changes_on_changed_possession_to_model old_owner, new_owner, empire_unlock_fields
        
        # propagate fields to alliance
        alliance_change = self.changes[:alliance_id]
        if !alliance_change.blank?
          old_ally = alliance_change[0].nil? ? nil : Fundamental::Alliance.find_by_id(alliance_change[0])
          new_ally = alliance_change[1].nil? ? nil : Fundamental::Alliance.find_by_id(alliance_change[1])
          propagate_unlock_changes_on_changed_possession_to_model old_ally, new_ally, alliance_unlock_fields
        else                      # use the standard method
          propagate_unlock_changes_to_model(self.alliance, alliance_unlock_fields)  unless self.alliance_id.nil? || self.alliance_id == 0
        end
      end
    end
        
        
        
    def propagate_unlock_changes_on_changed_possession_to_model(old_model, new_model, fields)

      fields.each do |entry| 
        old_value = self[entry[:attrl]]
        new_value = self[entry[:attrl]]
        
        if !self.changes[entry[:attrl]].nil?
          change = self.changes[entry[:attrl]]
          new_value = (change[1] || 0)
          old_value = (change[0] || 0)
        end
        
        old_model.decrement(entry[:attrc], old_value)   unless old_model.nil?
        new_model.increment(entry[:attrc], new_value)   unless new_model.nil? 
      end

      old_model.save   unless old_model.nil?
      new_model.save   unless new_model.nil?
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
    def propagate_changes_to_resource_pool_on_changed_possession
      owner_change = self.changes[:owner_id]
      if !owner_change.blank?
        old_owner = owner_change[0].nil? ? nil : Fundamental::Character.find_by_id(owner_change[0])
        new_owner = owner_change[1].nil? ? nil : Fundamental::Character.find_by_id(owner_change[1])

        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          attribute = resource_type[:symbolic_id].to_s() + '_production_rate'
          old_value = self[attribute]
          new_value = self[attribute]
          if !self.changes[attribute].nil?
            change = self.changes[attribute]
            new_value = (change[1] || 0)
            old_value = (change[0] || 0)
          end
          
          old_owner.resource_pool[attribute] = (old_owner.resource_pool[attribute] || 0.0) - old_value   unless old_owner.nil?
          new_owner.resource_pool[attribute] = (new_owner.resource_pool[attribute] || 0.0) + new_value   unless new_owner.nil? 
        end

        old_owner.resource_pool.save   unless old_owner.nil?
        new_owner.resource_pool.save   unless new_owner.nil?
      end
      true
    end
    

    
    def propagate_score_on_changed_possession
      owner_change = self.changes[:owner_id]
      if !owner_change.blank?
        old_owner = owner_change[0].nil? ? nil : Fundamental::Character.find_by_id(owner_change[0])
        new_owner = owner_change[1].nil? ? nil : Fundamental::Character.find_by_id(owner_change[1])
        
        old_value = new_value = (self.score || 0)

        score_change = self.changes[:score] 
        if !score_change.nil?
          new_value = (score_change[1] || 0)
          old_value = (score_change[0] || 0)
        end   
          
        old_owner.score = (old_owner.score || 0) - old_value   unless old_owner.nil?
        new_owner.score = (new_owner.score || 0) + new_value   unless new_owner.nil? 

        old_owner.save   unless old_owner.nil?
        new_owner.save   unless new_owner.nil?
      end
      true      
    end
    

end
