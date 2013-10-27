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
    quest = self.quests.create({          # hack. as the settler-quest won't be reached in this tutorial-graph, it'll be marked as finished right from the start
      quest_id:     GAME_SERVER_CONFIG['settler_start_quest_id'],
      status:       Tutorial::Quest::STATE_CLOSED,    
      finished_at:  Time.now,
      reward_displayed_at: Time.now,
      displayed_at: Time.now
    })
    
    self.quests.create({
      quest_id:     0,
      status:       Tutorial::Quest::STATE_NEW,
    })
  end
  
  def create_settler_start_quest_state
    quest = self.quests.create({
      quest_id:     GAME_SERVER_CONFIG['settler_start_quest_id'],
      status:       Tutorial::Quest::STATE_NEW,       
    })
    
    logger.debug "Created a settler quest with id #{ GAME_SERVER_CONFIG['settler_start_quest_id'] }: #{ quest.inspect}."
    
    quest
  end

  def check_consistency
    # durchlaufe alle beendeten quest_states
    self.finished_quests.each do |quest_state|
      # durchlauf alle nachfolge-quests
      quest_state.quest[:successor_quests].each do |quest_id|
        # if qe.nachfolger nicht vorhanden
        if self.quest_state_with_quest_id(quest_id).nil?
          # offenen nachfolger erzeugen
          logger.debug "create missing quest_state: quest_id #{quest_id} for character #{self.owner.id}"
         self.quests.create({
           quest_id: quest_id,
           status: Tutorial::Quest::STATE_NEW,
         })
        end
      end
    end
  end
  
  
  def completed_tutorial_end_quest?
    self.finished_quests.each do |quest_state|
      if quest_state.quest[:tutorial_end_quest]
        return true
      end  
    end
    false
  end
end
