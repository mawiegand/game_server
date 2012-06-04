class AddBuildingIdToConstructionJob < ActiveRecord::Migration
  def change
    add_column :construction_jobs, :building_id, :integer
  end
end
