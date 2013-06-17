class AddMessageSentToTutorialQuest < ActiveRecord::Migration
  def change
    add_column :tutorial_quests, :message_sent, :boolean, :default => false, :null => false
  end
end
