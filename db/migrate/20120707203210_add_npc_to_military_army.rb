class AddNpcToMilitaryArmy < ActiveRecord::Migration
  def change
    add_column :military_armies, :npc, :boolean, { :default => false, :null => false}
  end
end
