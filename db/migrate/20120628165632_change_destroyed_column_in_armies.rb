class ChangeDestroyedColumnInArmies < ActiveRecord::Migration
  def change
  	rename_column :military_armies, :destroyed, :removed
  end
end
