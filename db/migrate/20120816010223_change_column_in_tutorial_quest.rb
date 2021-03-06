class ChangeColumnInTutorialQuest < ActiveRecord::Migration
  def up
    remove_column  :tutorial_quests, :status
    add_column     :tutorial_quests, :status, :integer, :default => 0, :nil => false
  end

  def down
    remove_column  :tutorial_quests, :status
    add_column     :tutorial_quests, :status, :boolean
  end
end
