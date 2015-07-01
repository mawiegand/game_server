class Tutorial::State < ActiveRecord::Base

  belongs_to  :owner,           :class_name => "Fundamental::Character",  :foreign_key => "character_id", :inverse_of => :tutorial_state

  has_many    :quests,          :class_name => "Tutorial::Quest",         :foreign_key => "state_id",     :inverse_of => :tutorial_state
  has_many    :open_quests,     :class_name => "Tutorial::Quest",         :foreign_key => "state_id",     :conditions => ["status < ?", Tutorial::Quest::STATE_FINISHED]
  has_many    :finished_quests, :class_name => "Tutorial::Quest",         :foreign_key => "state_id",     :conditions => ["status >= ?", Tutorial::Quest::STATE_FINISHED]
  
  
  def quest_state_with_quest_id(quest_id)
    self.quests.each do |quest_state|
      if quest_state.quest_id == quest_id
        return quest_state
      end
    end
    nil
  end
  
  def open_quest_state_with_quest_id(quest_id)
    self.open_quests.each do |quest_state|
      if quest_state.quest_id == quest_id
        return quest_state
      end
    end
    nil
  end

  def create_start_quest_state
    # TODO: SOLVE THE START-QUEST-ISSUE
    #quest = self.quests.create({          # hack. as the settler-quest won't be reached in this tutorial-graph, it'll be marked as finished right from the start
    #  quest_id:     GAME_SERVER_CONFIG['settler_start_quest_id'],
    #  status:       Tutorial::Quest::STATE_CLOSED,    
    #  finished_at:  Time.now,
    #  reward_displayed_at: Time.now,
    #  displayed_at: Time.now
    #})
    
    self.quests.create({
      quest_id:     0,
      status:       Tutorial::Quest::STATE_NEW,
    })
  end
  
  def create_settler_start_quest_state
    return create_start_quest_state  # TODO: BECAUSE SETTLER START QUEST WAS COMMENTED OUT (WHO DID THAT; WHY?), WE CANNOT USE THIS BRANCH
    
    quest = self.quests.create({
      quest_id:     GAME_SERVER_CONFIG['settler_start_quest_id'],
      status:       Tutorial::Quest::STATE_NEW,       
    })
    
    logger.debug "Created a settler quest with id #{ GAME_SERVER_CONFIG['settler_start_quest_id'] }: #{ quest.inspect}."
    
    quest
  end

  def check_for_new_quests(trigger_type = 'all')
    trigger_type = 'finish_quest_triggers' unless completed_tutorial_end_quest?
    quests = Tutorial::Tutorial.the_tutorial.quests

    quests.each do |quest|
      if self.quests.where(:quest_id => quest[:id]).empty?
        unless quest[:triggers].nil?
           # if trigger type == all or quest includes trigger type
           if trigger_type == 'all' || !quest[:triggers][trigger_type.to_sym].nil?
             # if all triggers for quest are valid and the quest is not a subquest create new quest
             if validate_quest_triggers(quest[:id]) && quest[:type].to_s != 'sub'
               self.quests.create({
                 status: Tutorial::Quest::STATE_NEW,
                 quest_id: quest[:id],
               })
               # open related subquests
               unless quest[:subquests].nil?
                 quest[:subquests].each do |subquest|
                   self.quests.create({
                     status: Tutorial::Quest::STATE_NEW,
                     quest_id: subquest,
                   })
                 end
               end
             end
           end
        end
      end
    end
  end

  def check_consistency
    # check for new quests with all types
    self.check_for_new_quests
  end
  
  
  def completed_tutorial_end_quest?
    self.finished_quests.each do |quest_state|
      if quest_state.quest[:tutorial_end_quest]
        return true
      end  
    end
    false
  end

  def check_finished_quest(finished_quest_symbolic_str)
    # validate finished quests for required finished quest
    self.finished_quests.each do |finished_quest|
      if finished_quest_symbolic_str == finished_quest.quest[:symbolic_id].to_s
        return true
      end
    end
    false
  end

  private

  def validate_quest_triggers(quest_id)
    quest = Tutorial::Tutorial.the_tutorial.quests[quest_id]
    triggers = quest[:triggers]

    # check for triggers
    unless triggers.nil?
      # validate required finished quests
      unless triggers[:finish_quest_triggers].nil?
        triggers[:finish_quest_triggers].each do |trigger|
          return false unless check_finished_quest(trigger[:finish_quest_trigger].to_s) # false if required quest is not finished
        end
      end
      # ignore all different triggers if quest is tutorial quest
      return true if quest[:tutorial] == true
      # validate play time trigger
      unless triggers[:play_time_trigger].nil?
        return false if self.owner.playtime < triggers[:play_time_trigger]
      end
      # validate logged in on second day trigger
      unless triggers[:logged_in_on_second_day_trigger].nil?
        return false unless self.owner.logged_in_on_second_day?
      end
      # validate mundane rank of owner
      unless triggers[:mundane_rank_trigger].nil?
        return false if self.owner.mundane_rank < triggers[:mundane_rank_trigger]
      end
      # validate victories count of owner
      unless triggers[:victories_count_trigger].nil?
        return false if self.owner.victories < triggers[:victories_count_trigger]
      end
      # validate received likes count of owner
      unless triggers[:likes_count_trigger].nil?
        return false if self.owner.received_likes_count < triggers[:likes_count_trigger]
      end
    end
    true
  end
end
