class ChangeJobsCountColumnInConstructionQueue < ActiveRecord::Migration
  def up
   Construction::Queue.all.each do |q|
     q.jobs_count = 0 if q.jobs_count.nil?
     q.save
   end

    change_column  :construction_queues, :jobs_count, :integer, {:default => 0, :null => false}     
  end

  def down
    change_column  :construction_queues, :jobs_count, :integer
  end
end
