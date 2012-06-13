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
