class Construction::Queue < ActiveRecord::Base
  
  belongs_to :settlement,  :class_name => "Settlement::Settlement",  :foreign_key => "settlement_id", :inverse_of => :queues 
  
  has_many   :jobs,        :class_name => "Construction::Job",       :foreign_key => "queue_id",      :inverse_of => :jobs
  has_many   :active_jobs, :class_name => "Construction::ActiveJob", :foreign_key => "queue_id",      :inverse_of => :active_jobs
  
end
