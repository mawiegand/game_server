class Construction::ActiveJob < ActiveRecord::Base
  
  belongs_to :job,         :class_name => "Construction::Job",       :foreign_key => "job_id",        :inverse_of => :active_job 
  belongs_to :queue,       :class_name => "Construction::Queue",     :foreign_key => "queue_id",      :inverse_of => :active_jobs
  
end
