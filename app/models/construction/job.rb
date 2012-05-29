class Construction::Job < ActiveRecord::Base
  
  has_one    :active_job,  :class_name => "Construction::ActiveJob", :foreign_key => "job_id",    :inverse_of => :job
  
  belongs_to :queue,       :class_name => "Construction::Queue",     :foreign_key => "queue_id",  :inverse_of => :active_jobs,  :counter_cache => true
  belongs_to :slot,        :class_name => "Settlement::Slot",        :foreign_key => "slot_id",   :inverse_of => :jobs
  
end
