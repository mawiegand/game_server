require 'exception/http_exceptions'


# Representation of a resource pool. Most attributes here are set indirectly
# in response to changes in other models (e.g. building a resource producer,
# finding a treasure with resources). Some things can be done on the resource
# pool directly:
#   - spending resources by deducing the amount up to zero
#   - earning resources by adding it to the amount
#   - changing the global production_boni (alliance, science, effects),
#     changes will be spread to local models
class Fundamental::ResourcePool < ActiveRecord::Base
  
  belongs_to  :owner, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :resource_pool

  before_save :update_resources_on_production_rate_changes

  after_save  :propagate_bonus_changes
  
  RESOURCE_ID_CASH = 3
  
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

  # Adds the given resource to the resource pool.
  # Saves the resource with an atomic operation and updates
  # the timestamp of the resource pool  
  def add_resource_atomically(resource_id, amount)
    if !amount.nil? && amount != 0
      db_resource_name = GameRules::Rules.the_rules().resource_types[resource_id][:symbolic_id].to_s() + '_amount'
      Fundamental::ResourcePool.update_all(["#{db_resource_name} = coalesce(#{db_resource_name}, 0) + ?, updated_at = ?", amount, Time.now], ["character_id = ? and coalesce(#{db_resource_name}, 0) + ? >= 0", owner.id, amount])
    else
      false
    end
  end

  # adds the given effect to the resource pool.
  # this adds the speedup value to the appropriate global effects
  # value and updates the production rates through an after_save handler.   
  def add_effect_transaction(effect)
    attribute = GameRules::Rules.the_rules().resource_types[effect[:resource_id]][:symbolic_id].to_s()+'_production_bonus_effects'
    amount = effect[:bonus]
    
    raise BadRequestError.new("could not find effect field when adding effect") unless self.has_attribute?(attribute)
    raise BadRequestError.new("no amount for effect given") if amount.nil?
    
    self[attribute] += amount
    self.save
  end
  
  # removes the given effect from the resource pool.
  # this subtracts the speedup value from the appropriate global effects
  # value and updates the production rates through an after_save handler.   
  def remove_effect_transaction(effect)
    attribute = GameRules::Rules.the_rules().resource_types[effect[:resource_id]][:symbolic_id].to_s()+'_production_bonus_effects'
    amount = effect[:bonus]
    
    raise BadRequestError.new("could not find effect field when removing effect") unless self.has_attribute?(attribute)
    raise BadRequestError.new("no amount for effect given") if amount.nil?
    
    self[attribute] -= amount
    self.save    
  end
  
  def fill_with_start_resources_transaction(start_resource_modificator)
    start_resources = GameRules::Rules.the_rules().character_creation[:start_resources]
    unless start_resources.nil?
      start_resource_modificator = 1.0 if start_resource_modificator.nil?
      modified_start_resources = {}
      start_resources.each {|key, value| modified_start_resources[key] = value * start_resource_modificator}
      self.add_resources_transaction(modified_start_resources)
    end
  end
  
  protected
  
    def update_resource_in_ranking(totalProductionRate)
      return   if self.owner.nil? || self.owner.ranking.nil?     # NPCs might not have a ranking entry
      self.owner.ranking.resource_score = totalProductionRate
      self.owner.ranking.save
    end
  
    # updates the resource amounts if the rate changes with this write
    def update_resources_on_production_rate_changes
      if self.changed?
        changed = false
        totalProductionRate = 0;
        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          attribute = resource_type[:symbolic_id].to_s()+'_production_rate'
          totalProductionRate += self[attribute]
          if self.send resource_type[:symbolic_id].to_s()+'_production_rate_changed?'
            changed = true
          end
        end
        update_resource_in_ranking(totalProductionRate) if changed
        update_resource_amount if changed  
      end    
      true
    end
    
    
    ##########################################################################
    #
    #  SPREADING LOCAL CHANGES TO RELATED MODELS 
    #
    ##########################################################################
    
    # propagate changes to global effects down to settlements. During this
    # process, changes at settlements will propagate back to this model
    # setting the rates to new values (this is quite dangerous...)
    def propagate_bonus_changes

      if (!self.character_id.nil? && self.character_id > 0)         # only spread, if there's a resource pool
        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          
          to_check = [{
              attribute:           resource_type[:symbolic_id].to_s()+'_production_bonus_effects',
              attributeSettlement: resource_type[:symbolic_id].to_s()+'_production_bonus_global_effects',
            },
            {
              attribute:           resource_type[:symbolic_id].to_s()+'_production_bonus_alliance',
              attributeSettlement: resource_type[:symbolic_id].to_s()+'_production_bonus_alliance',
            },
            {
              attribute:           resource_type[:symbolic_id].to_s()+'_production_bonus_sciences',
              attributeSettlement: resource_type[:symbolic_id].to_s()+'_production_bonus_sciences',
            }
          ]
          to_check = to_check.select { |bonus| !self.changes[bonus[:attribute]].nil? } # filter those, that have changed

          if !to_check.nil? && to_check.length > 0
            self.owner.settlements.each do |settlement|
              to_check.each do |bonus|
                settlement.increment(bonus[:attributeSettlement], self.changes[bonus[:attribute]][1] - self.changes[bonus[:attribute]][0])               
              end
              settlement.save
            end
          end
        end
      end
      
      true
    end
    
end
