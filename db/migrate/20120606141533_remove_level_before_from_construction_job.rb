class RemoveLevelBeforeFromConstructionJob < ActiveRecord::Migration
  def up
    remove_column :construction_jobs, :level_before
  end

  def down
    add_column :construction_jobs, :level_before, :integer
  end
end
