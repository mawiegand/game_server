class AddPlaytimeFinishedToTutorialQuests < ActiveRecord::Migration
  def change
    add_column :tutorial_quests, :playtime_finished, :decimal
    add_column :tutorial_quests, :playtime_started, :decimal
  end
end
