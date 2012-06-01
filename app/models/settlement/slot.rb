class Settlement::Slot < ActiveRecord::Base

  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id",  :inverse_of => :slots
  
  has_many   :jobs,        :class_name => "Contstruction::Job",      :foreign_key => "slot_id",        :inverse_of => :slot


  # creates a building of the given id in this slot. assumes, the
  # building can be build in this slot according to the rules 
  # (= does not check the rules). calls all necesary handlers to
  # add unlocks, speedups and effects associated with this building.
  #
  # This method does NOT handle resource-costs etc., it's just 
  # responsible for updating the slot and propagating all effects
  # that are related to this change.
  def create_building(building_id_to_build)
    raise BadRequestError.new('Tried to construct a building in a slot that is not empty.') unless self.building_id.nil?
    self.building_id = building_id_to_build
    self.level = 1
    propagate_abilities(building_id_to_build, 0, 1)
    self.save

    
    # TODO: propagation of depending values needs to be implemented
  end
  
  # upgrades the building in this slot by one level. Also calls
  # all necessary handlers to update unlocks, speedups and effects
  # accordingly. Assumes, it's possible to do the building, does not
  # check the rules.
  #
  # This method does NOT handle resource-costs etc., it's just 
  # responsible for updating the slot and propagating all effects
  # that are related to this change.
  def upgrade_building
    raise BadRequestError.new('Tried to upgrade a non-existend building.') if self.building_id.nil?
    self.level = self.level + 1
    propagate_abilities(self.building_id, self.level-1, self.level)
    self.save
    
    # TODO: propagation of depending values needs to be implemented
  end
  
  # downgrades the building in this slot by one level. If the level
  # would reach zero, calls the destroy-building method instead.
  # Also calls all necessary handlers to update unlocks, speedups 
  # and effects accordingly. Assumes, it's possible to downgrade
  # the building, it does not check the rules.
  #  
  # This method does NOT handle resource-costs etc., it's just 
  # responsible for updating the slot and propagating all effects
  # that are related to this change.
  def donwgrade_building
    if level == 0 && building_id.nil?
      return false
    elsif level == 1
      return destroy_building
    else
      # TODO: needs to be implemented
    end
  end
  
  # completely destroys the building in this slot, thus setting
  # the building id to null and the level to zero. Calls all
  # necessary handlers to remove effects, unlocks and speedups
  # connected with this building.
  #
  # This method does NOT handle resource-costs etc., it's just 
  # responsible for updating the slot and propagating all effects
  # that are related to this change.
  def destroy_building
    if level == 0 && building_id.nil?
      return false
    else
      # TODO:   needs to be implemented
    end
  end
  
  def propagate_abilities(building_id, old_level, new_level)
    building_type = GameRules::Rules.the_rules().building_types[building_id]
    raise InternalServerError.new('did not find building id #{building_id} in rules.') if building_type.nil?
    if building_type[:abilities]
      if building_type[:abilities][:unlock_queue]
        building_type[:abilities][:unlock_queue].each do |rule| 
          propagate_unlock_queue(building_id, rule, old_level, new_level)
        end
      end
    end
  end
  
  def propagate_unlock_queue(building_id, rule, old_level, new_level)
    unlock_field = GameRules::Rules.the_rules().queue_types[rule[:queue_type_id]][:unlock_field]
    if old_level < new_level && new_level == rule[:level]
      self.settlement[unlock_field] = self.settlement[unlock_field] + 1
      if self.settlement[unlock_field] == 1
        self.settlement.save # save immediately to create queue as a side effect
      end
    elsif old_level > new_level && old_level == rule[:level]
      self.settlement[unlock_field] = self.settlement[unlock_field] - 1
      if self.settlement[unlock_field] == 0
        self.settlement.save # save immediately to destroy queue as a side effect
      end      
    end
  end

  
end
