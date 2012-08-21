class Tutorial::Quest < ActiveRecord::Base
  
  belongs_to  :tutorial_state,  :class_name => "Tutorial::State",  :foreign_key => "state_id", :inverse_of => :quests, :touch => true

  STATES = []
  STATE_NEW = 0
  STATES[STATE_NEW] = :new
  STATE_DISPLAYED = 1
  STATES[STATE_DISPLAYED] = :displayed
  STATE_CLOSED = 2
  STATES[STATE_CLOSED] = :closed
  
  def check_for_rewards
    logger.debug "check quest nr #{self.quest_id}"
    
    # quest aus 'm Tutorial holen
    # reward tests durchtesten
    tests = true
    
    if tests
      # falls positiv reward gutschreiben
      # quest auf beendet setzen
      self.status = STATE_CLOSED
      self.finished_at = Time.now
      self.save
      
      # folgende quests auf neu setzen
      # durchlaufe alle quests des tutorials
      quests = Tutorial::Tutorial.the_tutorial.quests
      
      logger.debug "---> quests " + quests.inspect
      
      quests.each do |quest|
        logger.debug "---> quest " + quest.inspect
        # falls ein mit abhängigkeit dabei ist
        if quest[:id] > self.quest_id && quest[:id] == self.quest_id + 1 ## abhängigkeit testen
          # erzeuge neue quest
          self.tutorial_state.quests.create({
            status: STATE_NEW,
            started_at: Time.now,
            quest_id: quest[:id],
          })
        end
      end
    end
  end
  
  def check_buildings
    
  end

  def check_settlements
    
  end

  def check_armies
    
  end

  def check_construction_queues
    
  end

  def check_training_queues
    
  end

  def check_custom
    
  end
  
  def grant_rewards
    
  end

  def grant_resources
    
  end

  def grant_construction_jobs
    
  end

  def grant_training_jobs
    
  end

end
