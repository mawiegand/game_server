class RemoveLevelAfterFromConstructionJob < ActiveRecord::Migration
  def up
    remove_column :construction_jobs, :level_after
  end

  def down
    add_column :construction_jobs, :level_after, :integer
  end
end
