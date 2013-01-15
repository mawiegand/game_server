class Tutorial::Quest < ActiveRecord::Base
  
  belongs_to  :tutorial_state,  :class_name => "Tutorial::State",  :foreign_key => "state_id", :inverse_of => :quests, :touch => true

  before_create :set_start_playtime
  before_save   :set_finished_playtime
  after_save :count_completed_tutorial_quests

  STATES = []
  STATE_NEW = 0
  STATES[STATE_NEW] = :new
  STATE_DISPLAYED = 1
  STATES[STATE_DISPLAYED] = :displayed
  STATE_FINISHED = 2
  STATES[STATE_FINISHED] = :finished
  STATE_CLOSED = 3
  STATES[STATE_CLOSED] = :closed
  
  def quest
    Tutorial::Tutorial.the_tutorial.quests[self.quest_id]
  end
  
  def belongs_to_tutorial?
    !quest.nil? && quest[:tutorial]
  end
  
  def check_for_rewards(answer_text)
    logger.debug "check quest nr #{self.quest_id} with answer_text #{answer_text}"
    
    # quest aus 'm Tutorial holen
    quest = Tutorial::Tutorial.the_tutorial.quests[self.quest_id]
    return false if quest.nil?
    
    # reward tests durchtesten
    reward_tests = quest[:reward_tests]
    
    unless reward_tests.nil?
      
      unless reward_tests[:resource_production_tests].nil?
        reward_tests[:resource_production_tests].each do |resource_production_test|
          unless check_resource_production(resource_production_test)
            return false
          end
        end
      end        
      
      unless reward_tests[:building_tests].nil?
        reward_tests[:building_tests].each do |building_test|
          unless building_test.nil?
            unless check_buildings(building_test)
              return false
            end
          end
        end
      end
      
      unless reward_tests[:settlement_tests].nil?
        reward_tests[:settlement_tests].each do |settlement_test|
          unless settlement_test.nil?
            unless check_settlements(settlement_test)
              return false
            end
          end
        end
      end

      unless reward_tests[:army_tests].nil?
        reward_tests[:army_tests].each do |army_test|
          unless army_test.nil?
            unless check_armies(army_test)
              return false
            end
          end
        end
      end
      
      unless reward_tests[:construction_queue_tests].nil?
        reward_tests[:construction_queue_tests].each do |construction_queue_test|
          unless construction_queue_test.nil?
            unless check_construction_queues(construction_queue_test)
              return false
            end
          end
        end
      end
      
      unless reward_tests[:training_queue_tests].nil?
        reward_tests[:training_queue_tests].each do |training_queue_test|
          unless training_queue_test.nil?
            unless check_training_queues(training_queue_test)
              return false
            end
          end
        end
      end
      
      unless reward_tests[:movement_test].nil?
        movement_test = reward_tests[:movement_test]
        unless movement_test.nil?
          unless check_movements
            return false
          end
        end
      end
      
      unless reward_tests[:alliance_test].nil?
        alliance_test = reward_tests[:alliance_test]
        unless alliance_test.nil?
          unless check_alliance
            return false
          end
        end
      end
      
      unless reward_tests[:textbox_test].nil?
        textbox_test = reward_tests[:textbox_test]
        unless check_textbox(textbox_test, answer_text)
          return false
        end
      end
      
      unless reward_tests[:kill_test].nil?
        kill_test = reward_tests[:kill_test]
        unless check_kills(kill_test)
          return false
        end
      end
      
      unless reward_tests[:army_experience_test].nil?
        army_experience_test = reward_tests[:army_experience_test]
        unless check_army_experience(army_experience_test)
          return false
        end
      end
      
      unless reward_tests[:score_test].nil?
        score_test = reward_tests[:score_test]
        unless check_score(score_test)
          return false
        end
      end
      
      unless reward_tests[:settlement_production_test].nil?
        settlement_production_test = reward_tests[:settlement_production_test]
        unless check_settlement_production(settlement_production_test)
          return false
        end
      end
      
      unless reward_tests[:building_speed_test].nil?
        building_speed_test = reward_tests[:building_speed_test]
        unless check_building_speed(building_speed_test)
          return false
        end
      end
      
      unless reward_tests[:custom_test].nil?
        custom_test = reward_tests[:custom_test]
      end

    else
      logger.debug 'no reward tests found'
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
      # logger.debug "---> open_dependent_quest_states " + quest.inspect + quest_states.inspect
      # falls ein mit abhängigkeit dabei ist
      if self.tutorial_state.quests.where(:quest_id => quest[:id]).empty? && self.required_by_quest_with_id(quest[:id])
        # erzeuge neue quest
        self.tutorial_state.quests.create({
          status: STATE_NEW,
          quest_id: quest[:id],
        })
      end
    end
  end
  
  def check_resource_production(test)
    pool = self.tutorial_state.owner.resource_pool
    return false    if pool.nil?
    
    symbol = test[:resource].to_s + '_production_rate'
    
    (pool[symbol.to_sym] || 0) >= (test[:minimum] || 0).to_f
  end
  
  def check_buildings(building_test)
    # check for min count and min level
    return false if building_test[:min_count].nil? || building_test[:min_level].nil?
    
    #check for building type
    building_type = nil
    GameRules::Rules.the_rules().building_types.each do |type|
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
  
  def check_settlements(settlement_test)
    # check for min count and type
    return false if settlement_test[:min_count].nil? || settlement_test[:type].nil?
    
    logger.debug "check_settlements: check if min #{settlement_test[:min_count]} settlements of type #{settlement_test[:type]} exists"
 
    settlement_type = nil
    GameRules::Rules.the_rules().settlement_types.each do |type|
      if type[:symbolic_id].to_s == settlement_test[:type].to_s
        settlement_type = type
        break
      end
    end
    return false if settlement_type.nil?
    
    # logger.debug "-----> check_settlements: type " + settlement_type.inspect

    settlements = self.tutorial_state.owner.settlements.where({type_id: settlement_type[:id]})
    # logger.debug "-----> check_settlements: settlements " + settlements.inspect
    # logger.debug "-----> check_settlements: result " + (!settlements.nil? && settlements.count >= settlement_test[:min_count]).to_s
    return !settlements.nil? && settlements.count >= settlement_test[:min_count]
  end

  def check_armies(army_test)
    # check for min count and min level
    return false if army_test[:min_count].nil? || army_test[:type].nil?
    
    logger.debug "check_armies: check if min #{army_test[:min_count]} armies of army type '#{army_test[:type]}' exists"
 
    army_count = 0
    self.tutorial_state.owner.armies.each do |army|
      if ((army.garrison? && army_test[:type].to_s == 'garrison' || !army.garrison? && army_test[:type].to_s == 'visible') &&
        !army.size_present.nil? && army.size_present > 0)
        army_count += (army.size_present || 0)
      end 
    end
    
    return army_count >= army_test[:min_count]
  end

  def check_construction_queues(queue_test)
    # check for min count
    return false if queue_test[:min_count].nil? || queue_test[:min_level].nil?
    
    #check for building type
    building_type = nil
    GameRules::Rules.the_rules().building_types.each do |type|
      if type[:symbolic_id].to_s == queue_test[:building].to_s
        building_type = type
        break
      end
    end
    return false if building_type.nil?
    
    logger.debug "check_construction_queues: check if min #{queue_test[:min_count]} buildings of type '#{queue_test[:building]}' are queued"

    # count jobs that meet the requirements of queue_test.
    # return true, if there are enough jobs.    
    check_count = 0
    self.tutorial_state.owner.settlements.each do |settlement|
      unless settlement.queues.nil?
        settlement.queues.each do |queue|
          unless queue.jobs.nil?
            queue.jobs.each do |job|
              if (building_type[:id] === job.building_id &&
                  (job.job_type == Construction::Job::TYPE_CREATE || job.job_type == Construction::Job::TYPE_UPGRADE)
                  job.level_after >= queue_test[:min_level])
                check_count += 1
                if check_count >= queue_test[:min_count]
                  return true
                end
              end 
            end
          end
        end
      end
    
      unless settlement.slots.nil?
        settlement.slots.each do |slot|
          if (!slot.level.nil? &&
              !slot.building_id.nil? &&
              building_type[:id] == slot.building_id &&
              slot.level >= queue_test[:min_level])
            check_count += 1
            if check_count >= queue_test[:min_count]
              return true
            end
          end
        end
      end
    end
    
    
    # queue check failed, if method reaches this point
    false
  end

  def check_training_queues(queue_test)
    # check for min count
    return false if queue_test[:min_count].nil?
    
    #check for building type
    unit_type = nil
    GameRules::Rules.the_rules().unit_types.each do |type|
      if type[:db_field].to_s == queue_test[:unit].to_s
        unit_type = type
        break
      end
    end
    return false if unit_type.nil?
    
    logger.debug "check_training_queues check if min #{queue_test[:min_count]} units of type '#{queue_test[:unit]}' are queued"

    # count jobs that meet the requirements of queue_test.
    # return true, if there are enough jobs.    
    check_count = 0
    self.tutorial_state.owner.settlements.each do |settlement|
      unless settlement.training_queues.nil?
        settlement.training_queues.each do |queue|
          unless queue.jobs.nil?
            queue.jobs.each do |job|
              if unit_type[:id] === job.unit_id
                check_count += 1
                if check_count >= queue_test[:min_count]
                  return true
                end
              end 
            end
          end
        end
      end
    end
    
    # queue check failed, if method reaches this point
    false
  end

  def check_movements
    armies = self.tutorial_state.owner.armies    
    if armies.nil?
      return false
    else
      return armies.where(mode: Military::Army::MODE_MOVING).count > 0
    end
  end

  def check_alliance    
    !self.tutorial_state.owner.alliance.nil?
  end

  def check_textbox(textbox_test, answer_text)
    
    test_id = textbox_test[:id]
    return false if test_id.nil?
    
    if test_id == 'test_army_rank'
      ranking = Ranking::CharacterRanking.find(:all, :order => "overall_score DESC, id asc")
      character_ranking = self.tutorial_state.owner.ranking
      return answer_text == (ranking.index(character_ranking) + 1).to_s
    end
    
    if test_id == 'test_fortress_owner'
      fortress_owner = self.tutorial_state.owner.home_location.region.owner
      return answer_text == fortress_owner.name
    end
    
    if test_id == 'test_costs'
      building_type = nil
      GameRules::Rules.the_rules().building_types.each do |type|
        if type[:symbolic_id].to_s == 'building_barracks'
          building_type = type
          break
        end
      end
      return false if building_type.nil?
      
      resource_type = nil
      GameRules::Rules.the_rules().resource_types.each do |type|
        if type[:symbolic_id].to_s == 'resource_wood'
          resource_type = type
          break
        end
      end
      return false if resource_type.nil?
      
      formula = Util::Formula.parse_from_formula(building_type[:costs][resource_type[:id]])
      amount = formula.apply(2)
      
      return amount.to_s == answer_text
    end
    
    if test_id == 'test_recruit_friends_reward'
      return true
    end
      
    false
  end

  def check_kills(kill_test) 
    return false if kill_test[:min_units].nil?
    
    logger.debug "check_kills: check if min #{kill_test[:min_units]} units are already killed"
    
    self.tutorial_state.owner.kills >= kill_test[:min_units]
  end

  def check_army_experience(army_experience_test) 
    return false if army_experience_test[:min_experience].nil?
    
    logger.debug "check_army_experience: check if one army has at least #{army_experience_test[:min_experience]} XP"
    
    self.tutorial_state.owner.armies.each do |army|
     return true if army.exp >= army_experience_test[:min_experience]
    end
    false
  end

  def check_score(score_test) 
    return false if score_test[:min_population].nil?
    
    logger.debug "check_score: check if a min score of #{score_test[:min_population]} is already reached"
    
    self.tutorial_state.owner.score >= score_test[:min_population]
  end
  
  def check_settlement_production(settlement_production_test) 
    return false if settlement_production_test[:min_resources].nil?
    
    logger.debug "check_settlement_production: check if one settlement has at least a weighted resource production of #{settlement_production_test[:min_resources]} "
    
    production_test_weights = Tutorial::Tutorial.the_tutorial.production_test_weights
    
    self.tutorial_state.owner.settlements.each do |settlement|
      resources = 0.0
      GameRules::Rules.the_rules().resource_types.each do |type|
        resources += settlement[type[:symbolic_id].to_s + '_production_rate'] * (production_test_weights[type[:symbolic_id].to_sym] || 0)
      end
      return true if resources >= settlement_production_test[:min_resources]
    end

    false
  end
  
  def check_building_speed(building_speed_test) 
    return false if building_speed_test[:min_speed].nil?
    
    logger.debug "check_building_speed: check if home settlement has at least a building queue speed of #{building_speed_test[:min_speed]}"
    
    production_test_weights = Tutorial::Tutorial.the_tutorial.production_test_weights
    
    building_queue = self.tutorial_state.owner.home_location.settlement.queues.where("type_id = ?", queue_type[:id]).first
    true
  end
  
  def redeem_rewards
    # quest aus 'm Tutorial holen
    quest = Tutorial::Tutorial.the_tutorial.quests[self.quest_id]
    raise BadRequestError.new('quest not fount in tutorial') if quest.nil?
    
    rewards = quest[:rewards]
    raise BadRequestError.new('no rewards found in quest') if rewards.nil?
    resource_rewards = rewards[:resource_rewards]
    unit_rewards = rewards[:unit_rewards]


    # calc resources
    resources = {}
    unless resource_rewards.nil?
      resource_rewards.each do |resource_reward|
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
    end
    
    
    # calc units
    garrison_army = self.tutorial_state.owner.home_location.garrison_army
    raise BadRequestError.new("home location of character #{self.tutorial_state.owner.id} has no garrison army") if garrison_army.nil?
    
    units = {}
    total_unit_amount = 0
    unless unit_rewards.nil?
      unit_rewards.each do |unit_reward|
        raise BadRequestError.new('no unit_reward given') if unit_reward.nil?
        
        amount = unit_reward[:amount]
        raise BadRequestError.new('no amount given') if amount.nil?
        raise BadRequestError.new('amount is negative') if amount < 0
        
        unit_db_field = unit_reward[:unit]
        raise BadRequestError.new('no unit id given') if unit_db_field.nil?
        
        units[unit_db_field] = amount
        total_unit_amount += amount
      end
    end

    # check if resources and units can be rewarded
    # raise ConflictError.new("too many resources") unless self.tutorial_state.owner.resource_pool.can_receive?(total_resource_amount)
    raise ConflictError.new("too many units") unless garrison_army.can_receive?(total_unit_amount)

    Tutorial::Quest.transaction do
      # close quest
      self.lock!
      self.status = STATE_CLOSED
      self.closed_at = Time.now
      self.save
  
      # reward resources, units, experience and action points
      self.tutorial_state.owner.resource_pool.add_resources_transaction(resources)    
      garrison_army.add_units(units)
      unless rewards[:experience_reward].nil?
        self.tutorial_state.owner.increment(:exp, rewards[:experience_reward])
        self.tutorial_state.owner.save
      end
      if !rewards[:action_point_reward].nil? && rewards[:action_point_reward]
        self.tutorial_state.owner.armies.each do |army|
          army.ap_present = army.ap_max
          army.save          
        end
      end
    end
    
    # check queues for waiting jobs, that can start with rewarded resources
    self.tutorial_state.owner.settlements.each do |settlement|
      settlement.queues.each do |queue|
        queue.check_for_new_jobs
      end
      settlement.training_queues.each do |queue|
        queue.check_for_new_jobs
      end
    end 
  end
  
  def required_by_quest_with_id(next_quest_id)
    quests = Tutorial::Tutorial.the_tutorial.quests
    this_quest = quests[self.quest_id]
    next_quest = quests[next_quest_id]
    
    return false if this_quest.nil? || next_quest.nil? || next_quest[:requirement].nil? || next_quest[:requirement][:quest].nil?
    
    next_quest[:requirement][:quest].to_s == this_quest[:symbolic_id].to_s
  end
  
  protected
  
    def count_completed_tutorial_quests
      if self.status_changed? && !self.status.nil? && self.status == STATE_FINISHED && self.belongs_to_tutorial?
        self.tutorial_state.increment(:tutorial_states_completed)
        self.tutorial_state.save
      end
    end
    
    def set_start_playtime
      unless tutorial_state.nil? || tutorial_state.owner.nil?
        self.playtime_started = tutorial_state.owner.playtime || 0
      end
    end
      
    def set_finished_playtime
      if self.status_changed? && !self.status.nil? && self.status == STATE_FINISHED
        unless tutorial_state.nil? || tutorial_state.owner.nil?
          self.playtime_finished = tutorial_state.owner.playtime || 0
        end
      end
    end
        

end
