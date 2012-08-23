class RenameColumnStartedAtToDisplayedAtInTutorialQuest < ActiveRecord::Migration
    rename_column :tutorial_quests, :started_at, :displayed_at
end
