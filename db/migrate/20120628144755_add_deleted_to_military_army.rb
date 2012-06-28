class AddDeletedToMilitaryArmy < ActiveRecord::Migration
  def change
  	 add_column :military_armies, :destroyed, :boolean, {:default => false, :null => false}
  end
end
