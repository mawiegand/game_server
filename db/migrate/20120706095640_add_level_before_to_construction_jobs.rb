class AddLevelBeforeToConstructionJobs < ActiveRecord::Migration
  def change
    add_column :construction_jobs, :level_before, :integer, :default => 0
  end
end
