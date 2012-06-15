class Fundamental::ResourcePool < ActiveRecord::Base
  
  belongs_to :owner,    :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :resource_pool

  before_save :update_resources_on_production_rate_changes
  
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
  
  # Adds the given resources to the resource pool.
  # Will save resources, presently is neither a 
  # transaction nor an atomar operation. That'll change!
  # this will NOT update the produced resources
  def add_resources_transaction(resources)
    resources.each do |key, value| 
      self[key.to_s()+'_amount'] += value
    end
    self.save
  end
  
  # returns true, iff the resource pool holds at least
  # resources resources (not considering the resources
  # produced sinc the last update).
  def have_at_least_resources(resources) 
    sufficient = true
    resources.each do |key, value|
      sufficient = false if self[key.to_s()+'_amount'] < value
    end
    return sufficient
  end
  
  # Removes the given resources from the resource pool.
  # Will save resources, presently is neither a 
  # transaction nor an atomar operation. That'll change!
  # this will NOT update the produced resources  
  def remove_resources_transaction(resources)
    update_resource_amount if !have_at_least_resources(resources) # not enough? -> update production     
    return false           if !have_at_least_resources(resources) # still not enough? -> return false
    resources.each do |key, value|
      self[key.to_s()+'_amount'] -= value
    end     
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
        update_resource_amount    if changed  
      end    
      true
    end

end
