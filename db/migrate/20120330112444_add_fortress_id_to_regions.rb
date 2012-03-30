class AddFortressIdToRegions < ActiveRecord::Migration
  def change
    add_column :map_regions, :fortress_id, :integer
  end
end
