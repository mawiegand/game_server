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
    self.quests.create({
      quest_id: 0,
      status: Tutorial::Quest::STATE_NEW,
    })
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
end
