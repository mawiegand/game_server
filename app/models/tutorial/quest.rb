class Tutorial::Quest < ActiveRecord::Base
  
  belongs_to  :tutorial_state,  :class_name => "Tutorial::State",  :foreign_key => "state_id", :inverse_of => :quests, :touch => true

  STATES = []
  STATE_NEW = 0
  STATES[STATE_NEW] = :new
  STATE_DISPLAYED = 1
  STATES[STATE_DISPLAYED] = :displayed
  STATE_FINISHED = 2
  STATES[STATE_FINISHED] = :finished
  STATE_CLOSED = 3
  STATES[STATE_CLOSED] = :closed
  
  def check_for_rewards
    logger.debug "check quest nr #{self.quest_id}"
    
    # quest aus 'm Tutorial holen
    quest = Tutorial::Tutorial.the_tutorial.quests[self.quest_id]
    return false if quest.nil?
    logger.debug "---------------> quests" + quest.inspect
    
    # reward tests durchtesten
    reward_tests = quest[:reward_tests]
    logger.debug "---------------> reward_tests" + reward_tests.inspect
    
    unless reward_tests.nil?
      reward_tests.each do |reward_test|
        if !reward_test[:building_test].nil?
          logger.debug "---------------> building test " + reward_test[:building_test].inspect
          unless check_buildings(reward_test[:building_test])
            return false
          end
        elsif reward_test[:army_test]
          logger.debug "---------------> army test " + reward_test[:army_test].inspect
          unless check_armies(reward_test[:army_test])
            return false
          end
        else
          logger.debug 'unknown reward test'
          #add other tests here
        end  
      end
    end
    # quest auf beendet setzen
    self.status = STATE_FINISHED
    self.finished_at = Time.now
    self.save
    
    true
  end
  
  def open_dependent_quest_states
    # durchlaufe alle quests des tutorials
    quests = Tutorial::Tutorial.the_tutorial.quests
    #logger.debug "---> quests " + quests.inspect
    
    quest_states = self.tutorial_state.quests
    #logger.debug "---> quest_states " + quest_states.inspect
    
    quests.each do |quest|
      #logger.debug "---> quest " + quest.inspect
      # falls ein mit abhängigkeit dabei ist
      if quest_states[quest[:id]].nil? && quest[:id] > self.quest_id && self.required_by_quest_with_id(quest[:id])
        # erzeuge neue quest
        self.tutorial_state.quests.create({
          status: STATE_NEW,
          quest_id: quest[:id],
        }) 
      end
    end
  end
  
  def check_buildings(building_test)
    # check for min count and min level
    return false if building_test[:min_count].nil? || building_test[:min_level].nil?
    
    #check for building type
    building_type = nil
    GameRules::Rules.the_rules().building_types.each do |type|
      logger.debug "check_buildings: #{type[:symbolic_id]} #{building_test[:building]}" 
      if type[:symbolic_id].to_s == building_test[:building].to_s
        building_type = type
        break
      end
    end
    return false if building_type.nil?
    
    logger.debug "check_buildings: check if min #{building_test[:min_count]} buildings of type '#{building_test[:building]}' with min level #{building_test[:min_level]} exists"

    # count slots that meet the requirements of building_test.
    # return true, if there are enough buildings.    
    check_count = 0
    self.tutorial_state.owner.settlements.each do |settlement|
      unless settlement.slots.nil?
        settlement.slots.each do |slot|
          if (!slot.level.nil? &&
              !slot.building_id.nil? &&
              building_type[:id] == slot.building_id &&
              slot.level >= building_test[:min_level])
            check_count += 1
            if check_count >= building_test[:min_count]
              return true
            end
          end
        end
      end
    end
    
    # building check failed, if method reaches this point
    false
  end

  def check_settlements
    
  end

  def check_armies(army_test)
    logger.debug '-----> army_test' + army_test.inspect
    true
  end

  def check_construction_queues
    
  end

  def check_training_queues
    
  end

  def check_custom
    
  end
  
  def redeem_rewards
    # alle grants durchlaufen
    logger.debug '-----> redeem_rewards'
    
    # quest aus 'm Tutorial holen
    quest = Tutorial::Tutorial.the_tutorial.quests[self.quest_id]
    raise BadRequestError.new('quest not fount in tutorial') if quest.nil?
    logger.debug "---------------> quests" + quest.inspect
    
    rewards = quest[:rewards]
    logger.debug "---------------> rewards" + rewards.inspect
    
    resource_rewards = rewards[:resource_rewards]
    logger.debug "---------------> rewards" + rewards.inspect
    
    unless resource_rewards.nil?
      resources = {}
      resource_rewards.each do |resource_reward|
        logger.debug "---------------> resource reward " + resource_reward.inspect
        add_resource(resources, resource_reward)
      end

      logger.debug "---------------> resources to reward " + resources.inspect
      self.tutorial_state.owner.resource_pool.add_resources_transaction(resources)
    end

    # close quest
    self.status = STATE_CLOSED
    self.closed_at = Time.now
    self.save
  end

  def add_resource(resources, resource_reward)
    raise BadRequestError.new('no resource_reward given') if resource_reward.nil?
    
    amount = resource_reward[:amount]
    raise BadRequestError.new('no amount given') if amount.nil?
    raise BadRequestError.new('amount is negative') if amount < 0
    
    resource_symbolic_id = resource_reward[:resource]
    raise BadRequestError.new('no resource id given') if resource_symbolic_id.nil?
    
    resource_type = nil
    GameRules::Rules.the_rules().resource_types.each do |type|
      logger.debug "grant_resources: #{type[:symbolic_id]} #{resource_symbolic_id}" 
      if type[:symbolic_id].to_s == resource_symbolic_id.to_s
        resource_type = type
        break
      end
    end
    raise BadRequestError.new("no resource type found for resource symbolic id #{resource_symbolic_id}") if resource_type.nil?
    
    resources[resource_type[:id]] = (resources[resource_type[:id]] || 0) + amount
  end

  def required_by_quest_with_id(next_quest_id)
    quests = Tutorial::Tutorial.the_tutorial.quests
    this_quest = quests[self.quest_id]
    next_quest = quests[next_quest_id]
    
    return false if this_quest.nil? || next_quest.nil? || next_quest[:requirement].nil? || next_quest[:requirement][:quest].nil?
    
    logger.debug "-----> required_by_quest_with_id #{next_quest[:requirement][:quest].to_s}, #{this_quest[:symbolic_id].to_s}"
    next_quest[:requirement][:quest].to_s == this_quest[:symbolic_id].to_s
  end

end
