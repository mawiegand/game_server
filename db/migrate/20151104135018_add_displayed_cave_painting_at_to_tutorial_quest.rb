class AddDisplayedCavePaintingAtToTutorialQuest < ActiveRecord::Migration
  def change
    add_column :tutorial_quests, :displayed_cave_painting_at, :datetime
  end
end
