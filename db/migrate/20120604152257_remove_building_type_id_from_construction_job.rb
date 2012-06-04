class RemoveBuildingTypeIdFromConstructionJob < ActiveRecord::Migration
  def up
    remove_column :construction_jobs, :building_type_id
  end

  def down
    add_column :construction_jobs, :building_type_id, :integer
  end
end
