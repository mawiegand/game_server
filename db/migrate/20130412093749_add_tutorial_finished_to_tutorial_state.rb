class AddTutorialFinishedToTutorialState < ActiveRecord::Migration
  def change
    add_column :tutorial_states, :tutorial_finished, :boolean, :null => false, :default => false
  end
end
