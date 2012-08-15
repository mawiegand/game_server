class Tutorial::State < ActiveRecord::Base

  belongs_to  :owner,        :class_name => "Fundamental::Character",  :foreign_key => "character_id", :inverse_of => :resource_pool

  has_many    :quests,       :class_name => "Tutorial::Quest",         :foreign_key => "state_id",     :inverse_of => :tutorial_state
  has_many    :open_quests,  :class_name => "Tutorial::Quest",         :foreign_key => "state_id",     :conditions => ["status = ?", 0]

end
