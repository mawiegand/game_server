class AddCharacterIdToTutorialQuest < ActiveRecord::Migration

  def up
    add_column    :tutorial_quests, :character_id, :integer
    
    Tutorial::Quest.all.each do |quest|
      if !quest.tutorial_state.nil?
        quest.character_id = quest.tutorial_state.character_id
        quest.save
      end
    end
  end
  
  def down
    remove_column :tutorial_quests, :character_id
  end
  
end
