class AddColumnsToActionMilitaryMoveArmyAction < ActiveRecord::Migration
  def change
    add_column :action_military_move_army_actions, :character_id, :integer
    add_column :action_military_move_army_actions, :target_reached_at, :datetime
    add_column :action_military_move_army_actions, :event_id, :integer
    add_column :action_military_move_army_actions, :next_action_id, :integer
  end
end
