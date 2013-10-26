class AddClaimedByToMapLocation < ActiveRecord::Migration
  def change
    add_column :map_locations, :claimed_by, :integer
  end
end
