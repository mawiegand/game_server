class AddAllianceColorToMapLocation < ActiveRecord::Migration
  def change
    add_column :map_locations, :alliance_color, :integer
  end
end
