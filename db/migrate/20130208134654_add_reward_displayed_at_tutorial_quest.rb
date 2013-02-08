class AddRewardDisplayedAtTutorialQuest < ActiveRecord::Migration
  def up
    add_column :tutorial_quests, :reward_displayed_at, :datetime
    
    Tutorial::Quest.all.each do |quest| 
      if !quest.closed_at.nil? 
        quest.reward_displayed_at = quest.closed_at
        quest.save
      end
    end
  end

  def down
    remove_column :tutorial_quests, :reward_displayed_at, :datetime
  end
end
