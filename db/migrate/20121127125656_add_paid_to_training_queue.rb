class AddPaidToTrainingQueue < ActiveRecord::Migration
  def up
    add_column :training_queues, :paid, :boolean, :default => false, :null => false
    
    Training::Job.all.each do |job|
      job.paid = true  if job.active?
      job.save
    end
  end
  
  def down
    remove_column :training_queues, :paid, :boolean
  end
end
