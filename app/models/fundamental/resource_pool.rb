class Fundamental::ResourcePool < ActiveRecord::Base
  
  
  
  belongs_to :owner,    :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :resource_pool

  before_save :update_resources_on_production_rate_changes

  after_save  :propagate_global_effect_changes

  
  # updates resource amounts BUT does NOT save to database itself.
  def update_resource_amount
    now = Time.now
    lastUpdate = self.productionUpdatedAt || now # last update, or now, if it has never been updated before.
    
    hours = (now - lastUpdate) / 3600.0    # hours since last update (this is a fration)

    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      base = resource_type[:symbolic_id].to_s()
      self[base+'_amount'] = self[base+'_amount'] + self[base+'_production_rate'] * hours
    end

    self.productionUpdatedAt = now 
  end    
  
  # returns true, iff the resource pool holds at least
  # resources resources (not considering the resources
  # produced sinc the last update).
  def have_at_least_resources(resources) 
    sufficient = true
    resources.each do |key, value|
      logger.debug "EVAL: #{value} , #{self[GameRules::Rules.the_rules().resource_types[key][:symbolic_id].to_s()+'_amount']}"
      sufficient = false if self[GameRules::Rules.the_rules().resource_types[key][:symbolic_id].to_s()+'_amount'] < value
    end
    return sufficient
  end
  
  # Removes the given resources from the resource pool.
  # Will save resources, presently is neither a 
  # transaction nor an atomar operation. That'll change!
  # this will NOT update the produced resources  
  def remove_resources_transaction(resources)
    return true if resources.empty? 
    update_resource_amount if !have_at_least_resources(resources) # not enough? -> update production     
    return false           if !have_at_least_resources(resources) # still not enough? -> return false
    resources.each do |key, value|
      self[GameRules::Rules.the_rules().resource_types[key][:symbolic_id].to_s()+'_amount'] -= value
    end     
    self.save
  end
  
  # Adds the given resources to the resource pool.
  # Will save resources, presently is neither a 
  # transaction nor an atomar operation. That'll change!
  # this will NOT update the produced resources  
  def add_resources_transaction(resources)
    return if resources.empty? 
    resources.each do |key, value|
      self[GameRules::Rules.the_rules().resource_types[key][:symbolic_id].to_s() + '_amount'] += value
    end     
    self.save
  end

  # adds the given effect to the resource pool.
  # this adds the speedup value to the appropriate global effects
  # value and updates the production rates through an after_save handler.   
  def add_effect_transaction(effect)
    logger.debug '---> in add_effect'
    logger.debug '---> ' + effect.inspect
    
    attribute = resource_type[effect[:resource_id]].to_s()+'_global_effects'
    amount = effect[:speedup]
    
    raise BadRequest.new("could not find effect field when adding effect") unless self.has_attribute?(attribute)
    raise BadRequest.new("no amount for effect given") if amount.nil?
    
    self[attribute] += amount
    self.save
  end
  
  # removes the given effect from the resource pool.
  # this subtracts the speedup value from the appropriate global effects
  # value and updates the production rates through an after_save handler.   
  def remove_effect_transaction(effect)
    logger.debug '---> in remove_effect'
    logger.debug '---> ' + effect.inspect
    
    attribute = resource_type[effect[:resource_id]].to_s()+'_global_effects'
    amount = effect[:speedup]
    
    raise BadRequest.new("could not find effect field when removing effect") unless self.has_attribute?(attribute)
    raise BadRequest.new("no amount for effect given") if amount.nil?
    
    self[attribute] -= amount
    self.save    
  end
  
  protected
  
    # updates the resource amounts if the rate changes with this write
    def update_resources_on_production_rate_changes
      if self.changed?
        changed = false
        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          attribute = resource_type[:symbolic_id].to_s()+'_production_rate'
          if self.send resource_type[:symbolic_id].to_s()+'_production_rate_changed?'
            changed = true
          end
        end
        update_resource_amount if changed  
      end    
      true
    end
    
    ##########################################################################
    #
    #  SPREADING LOCAL CHANGES TO RELATED MODELS 
    #
    ##########################################################################
    
    # propagate changes to global effects down to settlements. during this
    # process, changes at settlements will propagate back to this model
    # (this is quite dangerous...)
    #
    # Presently, the method will save each settlement several times; namely one
    # time for each changed resource-effect. This is ok, as long as we only
    # change one effect at a time (persently that's given).
    def propagate_global_effect_changes

      if (!self.character_id.nil? && self.character_id > 0)         # only spread, if there's a resource pool
        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          
          attribute = resource_type[:symbolic_id].to_s()+'_global_effects'
          attributeSettlement = resource_type[:symbolic_id].to_s()+'_production_bonus_effects'
          
          if !self.changes[attribute].nil?
            change = self.changes[attribute]
            delta = change[1] - change[0]   # new - old value
            
            self.character.settlements.each do |settlement|
              settlement[attributeSettlement] = settlement[attributeSettlement] + delta
              settlement.save
            end
          end
        end
      end
      
      true
    end
    
end
