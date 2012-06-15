class Training::ActiveJob < ActiveRecord::Base
  
  belongs_to :job,    :class_name => "Training::Job",   :foreign_key => "job_id",    :inverse_of => :active_job 
  belongs_to :queue,  :class_name => "Training::Queue", :foreign_key => "queue_id",  :inverse_of => :active_jobs
  
  has_one    :event,  :class_name => "Event::Event",    :foreign_key => "local_event_id",  :dependent => :destroy
 
end
