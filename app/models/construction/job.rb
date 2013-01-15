require 'util/formula'
require 'game_state/requirements'

class Construction::Job < ActiveRecord::Base
  
  has_one    :active_job,  :class_name => "Construction::ActiveJob", :foreign_key => "job_id",    :inverse_of => :job, :dependent => :destroy
  
  belongs_to :queue,       :class_name => "Construction::Queue",     :foreign_key => "queue_id",  :inverse_of => :jobs,  :counter_cache => true, :touch => true
  belongs_to :slot,        :class_name => "Settlement::Slot",        :foreign_key => "slot_id",   :inverse_of => :jobs
  
  TYPE_CREATE = 'create'
  TYPE_UPGRADE = 'upgrade'
  TYPE_DOWNGRADE = 'downgrade'
  TYPE_DESTROY = 'destroy'
  TYPE_CONVERT = 'convert'
  
  def active?
    !self.active_job.nil?
  end
  
  def building_time
    building_type = GameRules::Rules.the_rules.building_types[self.building_id]
    formula = Util::Formula.parse_from_formula(building_type[:production_time])
    if self.job_type == TYPE_CREATE || self.job_type == TYPE_UPGRADE
      return formula.apply(self.level_after)
    elsif self.job_type == TYPE_DESTROY
      time = 0
      1.upto(self.level_before) do |level|
        time += formula.apply(level)
      end
      return time
    elsif self.job_type == TYPE_CONVERT
      # calculate time sum of current building
      time = 0
      1.upto(self.level_before) do |level|
        time += formula.apply(level)
      end

      # calculate time sum of converted building
      converted_level_formula = Util::Formula.parse_from_formula(building_type[:conversion_option][:target_level_formula])
      converted_level = converted_level_formula.apply(self.level_before)
      
      # converted_building_type = GameRules::Rules.the_rules.building_type_with_symbolic_id(building_type[:conversion_option][:building])
      converted_building_type = nil
      GameRules::Rules.the_rules.building_types.each do |type|
        converted_building_type = type if type[:symbolic_id].to_s == building_type[:conversion_option][:building].to_s
      end
      
      converted_building_time_formula = Util::Formula.parse_from_formula(converted_building_type[:production_time])
      
      converted_time = 0
      1.upto(converted_level) do |level|
        converted_time += converted_building_time_formula.apply(level)
      end
      
      return [converted_time - time, converted_time * (1 - GameRules::Rules.the_rules.building_conversion[:time_factor])].max
    end
  end
  
  def costs
    costs = {}
    if self.job_type == TYPE_CREATE || self.job_type == TYPE_UPGRADE
      building_type = GameRules::Rules.the_rules.building_types[self.building_id]
      return {} if building_type[:costs].nil?
      building_type[:costs].each do |resource_id, formula|
        f = Util::Formula.parse_from_formula(formula)
        costs[resource_id] = f.apply(self.level_after)
      end
    elsif self.job_type == TYPE_CONVERT
      # calculate time sum of current building
      # building_type = GameRules::Rules.the_rules.building_type_with_id(self.building_id)
      building_type = GameRules::Rules.the_rules.building_types[self.building_id]
      raise InternalServerError.new("Could not find building id #{self.building_id} in rules") if building_type.nil?
      
      unless building_type[:costs].nil?
        building_type[:costs].each do |resource_id, formula|
          costs[resource_id] = 0
          f = Util::Formula.parse_from_formula(formula)
          1.upto(self.level_before) do |level|
            costs[resource_id] += f.apply(level)
            # logger.debug "---> cost #{resource_id.to_s} " + costs[resource_id].inspect
          end
        end
      end

      # calculate time sum of converted building
      converted_level_formula = Util::Formula.parse_from_formula(building_type[:conversion_option][:target_level_formula])
      converted_level = converted_level_formula.apply(self.level_before)
      
      # converted_building_type = GameRules::Rules.the_rules.building_type_with_symbolic_id(building_type[:conversion_option][:building])
      converted_building_type = nil
      GameRules::Rules.the_rules.building_types.each do |type|
        converted_building_type = type if type[:symbolic_id].to_s == building_type[:conversion_option][:building].to_s
      end
      converted_costs = {}
      unless converted_building_type[:costs].nil?
        converted_building_type[:costs].each do |resource_id, formula|
          converted_costs[resource_id] = 0
          f = Util::Formula.parse_from_formula(formula)
          1.upto(converted_level) do |level|
            converted_costs[resource_id] += f.apply(level)
            # logger.debug "---> conv.cost #{resource_id.to_s} " + converted_costs[resource_id].inspect
          end
          costs[resource_id] = [converted_costs[resource_id] - costs[resource_id], converted_costs[resource_id] * (1 - GameRules::Rules.the_rules.building_conversion[:cost_factor])].max
          # logger.debug "---> cost #{resource_id.to_s} " + costs[resource_id].inspect
        end
      end
    end
    return costs
  end
  
  def last_in_slot
    self == self.queue.sorted_jobs_for_slot(self.slot).last
  end
  
  def create_queueable?
    # logger.debug '---> create_queueable?'
    building_type = GameRules::Rules.the_rules.building_types[self.building_id]
    requirement_groups = building_type[:requirementGroups]
    raise ForbiddenError.new('Requirements not met.')  if !requirement_groups.nil? && !requirement_groups.empty? && !GameState::Requirements.meet_one_requirement_group?(requirement_groups, slot.settlement.owner, slot.settlement, slot)

    # logger.debug "---> create_queueable? #{self.level_after} #{queue.settlement.building_slots_available?} #{self.level_after == 1 && (slot.level.nil? || slot.level == 0) && slot.jobs.empty? && queue.settlement.building_slots_available?}"
    self.level_after == 1 && (slot.level.nil? || slot.level == 0) && slot.jobs.empty? && queue.settlement.building_slots_available?
    # TODO test if building can be build in slot according to the slots building categories
  end
  
  def upgrade_queueable?
    # logger.debug '---> upgrade_queueable?'
    building_type = GameRules::Rules.the_rules.building_types[self.building_id]
    requirement_groups = building_type[:requirementGroups]
    raise ForbiddenError.new('Requirements not met.')  if !requirement_groups.nil? && !requirement_groups.empty? && !GameState::Requirements.meet_one_requirement_group?(requirement_groups, slot.settlement.owner, slot.settlement, slot)

    self.level_after == slot.last_level + 1 &&
    self.level_after <= slot.max_level &&
    !slot.last_level.nil? && slot.last_level != 0 &&
    self.building_id == slot.building_id
  end
  
  # destroy job is only queueable, if there are no other jobs in queue
  def destroy_queueable?
    # logger.debug '---> destroy_queueable?'
    building_type = GameRules::Rules.the_rules.building_types[self.building_id]
    raise ForbiddenError.new('Building type is not demolishable.') unless building_type[:demolishable] && building_type[:demolishable] == true
    self.building_id == slot.building_id && !slot.last_level.nil? && slot.last_level != 0
  end
  
  def convert_queueable?
    # logger.debug '---> convert_queueable?'
    # conversion option testen
    building_type = GameRules::Rules.the_rules.building_types[self.building_id]
    conversion_option = building_type[:conversion_option]
    raise ForbiddenError.new('Building is not convertible.') if conversion_option.nil?
    # logger.debug '---> conversion_option ' + conversion_option.inspect
    
    requirement_groups = nil
    GameRules::Rules.the_rules.building_types.each do |type|
      requirement_groups = type[:requirementGroups] if type[:symbolic_id].to_s == conversion_option[:building].to_s
    end
    # requirement_groups = GameRules::Rules.the_rules.building_type_with_symbolic_id(conversion_option[:building])[:requirementGroups]
    
    # don't test self.slot for requirements of converted building
    raise ForbiddenError.new('Requirements not met.')  if !requirement_groups.nil? && !requirement_groups.empty? && !GameState::Requirements.meet_one_requirement_group?(requirement_groups, slot.settlement.owner, slot.settlement, slot)
    
    # level anhand formel testen
    formula = Util::Formula.parse_from_formula(conversion_option[:target_level_formula])
    converted_level = formula.apply(self.level_before)
    # logger.debug '---> converted_level ' + converted_level.inspect + ', level_after ' + level_after.inspect
    
    converted_level == self.level_after
  end
  
  # checks if a job can be queueable due to requirements like e.g. building levels
  def queueable?
    slot = self.slot
    settlement = slot.settlement
    
    # test if queue is already full   
    raise ForbiddenError.new('Queue is already full.') if self.queue && self.queue.max_length <= (self.queue.jobs_count || 0)
    
    # test same job type if queue has already jobs
    if (!slot.jobs.empty? && slot.jobs.first.job_type != self.job_type && (slot.jobs.first.job_type != TYPE_CREATE || self.job_type != TYPE_UPGRADE))
      raise ForbiddenError.new('Not allowed to mix destruction or conversion job with construction jobs.')  
    end
    
    # test correct level
    # return false if self.job_type == TYPE_CREATE    && (self.level_after != 1 || (!slot.level.nil? && slot.level != 0) || !slot.jobs.empty?)
    # return false if self.job_type == TYPE_UPGRADE   && (self.level_after != slot.last_level + 1 || self.level_after > slot.max_level)
    # return false if self.job_type == TYPE_DESTROY   && (slot.last_level.nil?  || slot.last_level == 0)
    
    # test correct level
    case self.job_type
      when TYPE_CREATE
        return false unless create_queueable?
      when TYPE_UPGRADE
        return false unless upgrade_queueable?
      when TYPE_DESTROY
        return false unless destroy_queueable?
      when TYPE_CONVERT
        return false unless convert_queueable?
    end    
    
    # test if building ability is unlocked in settlement
    return false unless settlement.settlement_queue_buildings_unlock_count > 0    # THIS IS AN ERROR: there are queues of other types (e.g. fortification)! either the client should post to the queue or you must search the correct (queue_type that is unlocked and able to build the building category of the building) queue here
    
    true
  end
  
  # checks if user owns enough resources for job and reduces them instantly
  def pay_for_job
    self.slot.settlement.owner.resource_pool.remove_resources_transaction(self.costs)
  end
  
  def refund_for_job
    self.slot.settlement.owner.resource_pool.add_resources_transaction(self.costs)
  end
  
  def buyable?
    building_type = GameRules::Rules.the_rules.building_types[self.building_id]    
    !building_type.nil? && building_type[:buyable]
  end
  
  def finish
    slot = self.slot
    
    if self.job_type == 'create'
      if slot.empty?
        # TODO check requirements like enough resources 

        slot.create_building(self.building_id)
      else
        raise ForbiddenError.new('slot is not empty')
      end        
    elsif self.job_type == 'upgrade'
      if !slot.empty?
        # TODO check requirements like enough resources 
        
        slot.upgrade_building
      else
        raise ForbiddenError.new('slot is empty')
      end        
    elsif self.job_type == 'downgrade'
      if !slot.empty?
        # TODO check requirements like enough resources 
        
        slot.downgrade_building
      else
        raise ForbiddenError.new('slot is empty')
      end        
    elsif self.job_type == 'destroy'
      if !slot.empty?
        # TODO check requirements like enough resources 
        
        slot.destroy_building
      else
        raise ForbiddenError.new('slot is empty')
      end        
    elsif self.job_type == 'convert'
      if !slot.empty?
        slot.convert_building
      else
        raise ForbiddenError.new('slot is empty')
      end        
    end
  end
  
end
