class AddFinishedTutorialStateToTutorialStates < ActiveRecord::Migration
  def change
    add_column :tutorial_states, :tutorial_states_completed, :integer, :default => 0, :null => false
  end
end
