class Tutorial::State < ActiveRecord::Base

  belongs_to  :owner,        :class_name => "Fundamental::Character",  :foreign_key => "character_id", :inverse_of => :tutorial_state

  has_many    :quests,       :class_name => "Tutorial::Quest",         :foreign_key => "state_id",     :inverse_of => :tutorial_state
  has_many    :open_quests,  :class_name => "Tutorial::Quest",         :foreign_key => "state_id",     :conditions => ["status < ?", Tutorial::Quest::STATE_FINISHED]
  
  def quest_state_with_quest_id(quest_id)
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

end
