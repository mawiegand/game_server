class AddCountQuestsCompletedToTutorialState < ActiveRecord::Migration
  def up
    add_column :tutorial_states, :count_quests_completed, :integer, :default => 0, :null => false
    
    Tutorial::State.all.each do |state| 
      state.count_quests_completed = state.finished_quests.count
      state.save
    end
  end
  
  def down
    add_column :tutorial_states, :count_quests_completed
  end
end
