class ChangeJobsCountColumnInConstructionQueue < ActiveRecord::Migration
  def up
    change_column  :construction_queues, :jobs_count, :integer, {:default => 0, :null => false}     
  end

  def down
    change_column  :construction_queues, :jobs_count, :integer
  end
end
