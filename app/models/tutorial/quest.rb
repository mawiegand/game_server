class Tutorial::Quest < ActiveRecord::Base
  
  belongs_to  :tutorial_state,  :class_name => "Tutorial::State",  :foreign_key => "state_id", :inverse_of => :quests

  STATES = []
  STATE_STARTED = 0
  STATES[STATE_STARTED] = :started
  STATE_FINISHED = 1
  STATES[STATE_FINISHED] = :finished
  
  def check
    logger.debug "check quest nr #{self.quest_id}"
    # quest aus 'm Tutorial holen
    # reward tests durchtesten
    # falls positiv reward gutschreiben
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
