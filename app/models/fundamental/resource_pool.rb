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
  
  belongs_to   :owner, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :resource_pool

  before_save  :update_resources_on_production_rate_changes

 # after_commit :propagate_bonus_changes   # don't use an after save handler. need to 
  
  RESOURCE_ID_CASH = 3
  
  def update_resource_amount
    now = Time.now
    lastUpdate = self.productionUpdatedAt || now # last update, or now, if it has never been updated before.

    hours = (now - lastUpdate) / 3600.0    # hours since last update (this is a fration)
    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      base = resource_type[:symbolic_id].to_s()
      self[base+'_amount'] = [self[base+'_amount'] + self[base+'_production_rate'] * hours, self[base+'_capacity']].min
    end
    self.productionUpdatedAt = now  
  end    
  
  def update_resource_amount_atomically
    set_clauses = []
    GameRules::Rules.the_rules().resource_types.each do |resource_type|
      base = resource_type[:symbolic_id].to_s()
      set_clauses << "#{base + '_amount'} = #{ Fundamental::ResourcePool.least_sql_fragment }(#{base + '_amount'} + #{ Fundamental::ResourcePool.produced_resource_amount_sql_fragment(base+'_production_rate')},  CAST(#{base+'_capacity'} AS double precision))"
    end  
    set_clauses << "\"productionUpdatedAt\" = #{ Fundamental::ResourcePool.now_sql_fragment }"
    set_clauses << "\"updated_at\" = #{ Fundamental::ResourcePool.now_sql_fragment }"
    Fundamental::ResourcePool.update_all(set_clauses.join(', ') , id: self.id) == 1 # affect exactly one row
  end
  
  def self.least_sql_fragment
    Rails.env.development? || Rails.env.test? ? 'MIN' : 'LEAST'
  end
  
  def self.now_sql_fragment
    Rails.env.development? || Rails.env.test? ? 'datetime("now")' : 'NOW()'
  end
  
  def self.elapsed_time_sql_fragment
    if Rails.env.development? || Rails.env.test?
      return @elapsed_time_sql_fragment ||= "(strftime('%s', #{ Fundamental::ResourcePool.now_sql_fragment }) - strftime('%s', COALESCE(productionUpdatedAt,  #{ Fundamental::ResourcePool.now_sql_fragment })))"
    else
      return @elapsed_time_sql_fragment ||= 'EXTRACT(EPOCH FROM (' + Fundamental::ResourcePool.now_sql_fragment + '-COALESCE("productionUpdatedAt", ' + Fundamental::ResourcePool.now_sql_fragment + ')))'      
    end
  end
  
  def self.produced_resource_amount_sql_fragment(resource_field)
    "(#{ Fundamental::ResourcePool.elapsed_time_sql_fragment } * (\"#{ resource_field }\" / 3600.0) )"
  end
  
  
  # returns true, iff the resource pool holds at least
  # resources resources (not considering the resources
  # produced sinc the last update).
  def have_at_least_resources(resources) 
    sufficient = true
    now = Time.now
    lastUpdate = self.productionUpdatedAt || now # last update, or now, if it has never been updated before.
    hours = (now - lastUpdate) / 3600.0    # hours since last update (this is a fration)

    resources.each do |key, value|
      base = GameRules::Rules.the_rules().resource_types[key][:symbolic_id].to_s()
      logger.debug "EVAL: #{value} , #{self[base+'_amount']}"
      present_amount = [self[base+'_amount'] + self[base+'_production_rate'] * hours, self[base+'_capacity']].min
      sufficient = false if present_amount < value
    end
    return sufficient
  end
  
  # Removes the given resources from the resource pool.
  # Will save resources, presently is neither a 
  # transaction nor an atomar operation. That'll change!
  # this will NOT update the produced resources  
  def remove_resources_transaction(resources)
    return true            if resources.empty? 
    return false           if !have_at_least_resources(resources) # still not enough? -> return false
    mresources = {}
    resources.each do |key, value|
      mresources[key] = -value
    end
    self.modify_resources_atomically(mresources)
  end
  
  # Adds the given resources to the resource pool.
  # Will save resources, presently is neither a 
  # transaction nor an atomar operation. That'll change!
  # this will NOT update the produced resources 
  def add_resources_transaction(resources)
    return true if resources.empty? 
    self.modify_resources_atomically(resources)
  end
  
  def self.modify_resource_sql_set_fragment(resource_symbol)
    "#{ resource_symbol + '_amount' } = \
      #{ Fundamental::ResourcePool.least_sql_fragment }(\
        COALESCE(#{ resource_symbol + '_amount' }, 0) + \
        #{ Fundamental::ResourcePool.produced_resource_amount_sql_fragment(resource_symbol+'_production_rate') } + ?, \
        CAST(#{ resource_symbol + '_capacity'} AS double precision))"
  end

  def self.modify_resource_sql_where_fragment(resource_symbol)
    "(#{ Fundamental::ResourcePool.least_sql_fragment }(\
        COALESCE(#{ resource_symbol + '_amount' }, 0) + \
        #{ Fundamental::ResourcePool.produced_resource_amount_sql_fragment(resource_symbol+'_production_rate') }, \
        CAST(#{ resource_symbol + '_capacity'} AS double precision)) + ? >= 0.0)"
  end
  
  # Adds the given resources to the resource pool.
  # Will save resources using an atomar operation.
  # this will NOT update the produced resources  
  def modify_resources_atomically(resources)
    return true if resources.empty? 
    set_clauses   = []
    where_clauses = []
    values        = []
    resources.each do |key, value|
      base     = GameRules::Rules.the_rules().resource_types[key][:symbolic_id].to_s()
      
      set_clauses   << Fundamental::ResourcePool.modify_resource_sql_set_fragment(base)
      where_clauses << Fundamental::ResourcePool.modify_resource_sql_where_fragment(base)

      values.push(value)
    end     
    set_clauses   << "\"productionUpdatedAt\" = #{ Fundamental::ResourcePool.now_sql_fragment }"
    set_clauses   << "\"updated_at\" = #{ Fundamental::ResourcePool.now_sql_fragment }"
    where_clauses << "(id = ?)"
    
    rows = Fundamental::ResourcePool.update_all([set_clauses.join(', '), *values ], [where_clauses.join(' AND '), *values, self.id])
    rows == 1
  end

  # Adds the given resource to the resource pool.
  # Saves the resource with an atomic operation and updates
  # the timestamp of the resource pool 
  # if you still want to work with the pool afterwards, you need to
  # reload it manually. 
  def add_resource_atomically(resource_id, amount)
    if !amount.nil? && amount != 0
      self.modify_resources_atomically({resource_id => amount})
    else
      false
    end
  end

  # adds the given effect to the resource pool.
  # this adds the speedup value to the appropriate global effects
  # value and updates the production rates through an after_save handler.   
  def add_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      attribute = GameRules::Rules.the_rules().resource_types[effect[:resource_id]][:symbolic_id].to_s()+'_production_bonus_effects'
      amount = effect[:bonus]
    
      raise BadRequestError.new("could not find effect field when adding effect") unless self.has_attribute?(attribute)
      raise BadRequestError.new("no amount for effect given") if amount.nil?
    
      self[attribute] += amount
      propagate_bonus_changes
      self.save!
    end
  end
  
  # removes the given effect from the resource pool.
  # this subtracts the speedup value from the appropriate global effects
  # value and updates the production rates through an after_save handler.   
  def remove_effect_transaction(effect)
    ActiveRecord::Base.transaction(:requires_new => true) do
      self.lock!
      attribute = GameRules::Rules.the_rules().resource_types[effect[:resource_id]][:symbolic_id].to_s()+'_production_bonus_effects'
      amount = effect[:bonus]
    
      raise BadRequestError.new("could not find effect field when removing effect") unless self.has_attribute?(attribute)
      raise BadRequestError.new("no amount for effect given") if amount.nil?
    
      self[attribute] -= amount
      propagate_bonus_changes
      self.save!
    end    
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
  
  
  def check_consistency
    logger.info(">>> COMPLETE RECALC of RESOURCE PRODUCTION in resource pool #{self.id} of character #{self.character_id}.")

    productions = recalc_resource_productions
    check_and_apply_productions(productions)

    capacities = recalc_resource_capacities
    check_and_apply_capacities(capacities)
    
    if self.changed?
      logger.warn(">>> SAVING RESOURCE POOL AFTER DETECTING ERRORS.")
      self.save
    else
      logger.info(">>> RESOURCE POOL OK.")
    end

    true      
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
        amount_changed = false
        weightedProductionRate = 0;      # weighted according to rating_value of resource type. will be used in the ranking.
        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          attribute = resource_type[:symbolic_id].to_s()+'_production_rate'
          weightedProductionRate += self[attribute] * (resource_type[:rating_value] || 0) 
          if self.send resource_type[:symbolic_id].to_s()+'_production_rate_changed?'
            changed = true
          end
          amount_changed = true     if self.send resource_type[:symbolic_id].to_s()+'_amount_changed?'
        end
        Rails.logger.error("ERROR : amounts were manually changed in resource pool at the same time as production rates change. THIS MUST BE PREVENTED SINCE IT CAUSES IMMEDIATE RESOURCE LOSSES.") if changed && amount_changed
        update_resource_in_ranking(weightedProductionRate) if changed
        update_resource_amount_atomically                  if changed  # this will completely bypass the rails object. needs to make sure no amounts are set directly.
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
      
      ActiveRecord::Base.transaction(:requires_new => true) do

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
                settlement.lock!
                to_check.each do |bonus|
                  settlement.increment(bonus[:attributeSettlement], self.changes[bonus[:attribute]][1] - self.changes[bonus[:attribute]][0])               
                end
                settlement.save!
              end
            end
          end
        end
      end
      
      true
    end 
    
    
    def check_consistency_sometimes
      return         unless rand(100) / 100.0 < GAME_SERVER_CONFIG['resource_pool_recalc_probability']       # do the check only seldomly (determined by random event)  
      check_consistency
    end
      
    def recalc_resource_productions
      resource_types = GameRules::Rules.the_rules().resource_types
      productions    = Array.new(resource_types.count, 0.0)
      self.owner.settlements.each do |settlement|
        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          field = resource_type[:symbolic_id].to_s + '_production_rate'
          productions[resource_type[:id]] += settlement[field] || 0.0
        end
      end
      return productions
    end
    
    def check_and_apply_productions(productions)
      GameRules::Rules.the_rules().resource_types.each do |resource_type|
        base = resource_type[:symbolic_id].to_s
        present = self[base+'_production_rate']
        recalc  = productions[resource_type[:id]]
        
        if (present - recalc).abs > 0.000001
          logger.warn(">>> PRODUCTION RATE RECALC DIFFERS for #{resource_type[:name][:en_US]}. Old: #{present} Corrected: #{recalc}.")
          self[base+'_production_rate'] = recalc
        end
      end    
    end
    
    def recalc_resource_capacities
      resource_types = GameRules::Rules.the_rules().resource_types
      capacities     = Array.new(resource_types.count, 0.0)
      self.owner.settlements.each do |settlement|
        GameRules::Rules.the_rules().resource_types.each do |resource_type|
          field = resource_type[:symbolic_id].to_s + '_capacity'
          capacities[resource_type[:id]] += settlement[field] || 0.0
        end
      end
      return capacities
    end
    
    def check_and_apply_capacities(capacities)
      GameRules::Rules.the_rules().resource_types.each do |resource_type|
        base = resource_type[:symbolic_id].to_s
        present = self[base+'_capacity']
        recalc  = capacities[resource_type[:id]]
        
        if (present - recalc).abs > 0.000001
          logger.warn(">>> RESOURCE CAPACITY RECALC DIFFERS for #{resource_type[:name][:en_US]}. Old: #{present} Corrected: #{recalc}.")
          self[base+'_capacity'] = recalc
        end
      end    
    end
    
end
