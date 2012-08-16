class ChangeColumnNameInTutorialQuest < ActiveRecord::Migration
  def change
    rename_column :tutorial_quests, :finished, :status
  end
end
