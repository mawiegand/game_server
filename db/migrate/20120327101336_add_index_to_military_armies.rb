class AddIndexToMilitaryArmies < ActiveRecord::Migration
  def change
    add_index :military_armies, :region_id
    add_index :military_armies, :location_id
    add_index :military_armies, :owner_id
    add_index :military_armies, :target_location_id
    add_index :military_armies, :target_region_id    
  end
end
