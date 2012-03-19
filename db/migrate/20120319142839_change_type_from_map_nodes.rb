class ChangeTypeFromMapNodes < ActiveRecord::Migration
  def change
    rename_column :map_locations, :type, :type_id
    rename_column :map_locations, :alliance_name, :alliance_tag
  end

end
