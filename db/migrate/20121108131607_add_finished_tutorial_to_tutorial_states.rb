class AddFinishedTutorialToTutorialStates < ActiveRecord::Migration
  def change
    add_column :tutorial_states, :tutorial_completed, :boolean, :default => false, :null => false
    add_column :tutorial_states, :displayed_tutorial_completion_notice_at, :datetime
  end
end
