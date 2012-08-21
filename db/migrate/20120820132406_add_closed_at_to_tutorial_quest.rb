class AddClosedAtToTutorialQuest < ActiveRecord::Migration
  def change
    add_column :tutorial_quests, :closed_at, :datetime
  end
end
