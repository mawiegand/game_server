class Tutorial::Quest < ActiveRecord::Base
  
  belongs_to  :tutorial_state,  :class_name => "Tutorial::State",  :foreign_key => "state_id", :inverse_of => :quests

  STATES = []
  STATE_STARTED = 0
  STATES[STATE_STARTED] = :started
  STATE_FINISHED = 1
  STATES[STATE_FINISHED] = :finished

end
