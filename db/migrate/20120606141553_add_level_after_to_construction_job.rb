class AddLevelAfterToConstructionJob < ActiveRecord::Migration
  def change
    add_column :construction_jobs, :level_after, :integer
  end
end
