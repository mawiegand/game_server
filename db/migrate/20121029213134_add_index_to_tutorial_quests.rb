class AddIndexToTutorialQuests < ActiveRecord::Migration
  def change
    add_index :tutorial_quests, :state_id
    add_index :tutorial_quests, :status    
  end
end
