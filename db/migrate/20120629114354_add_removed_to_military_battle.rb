class AddRemovedToMilitaryBattle < ActiveRecord::Migration
  def change
  	add_column :military_battles, :removed, :boolean, {:default => false, :null => false}
  end
end
