class Training::ActiveJob < ActiveRecord::Base
  
  belongs_to :job,    :class_name => "Training::Job",   :foreign_key => "job_id",    :inverse_of => :active_job 
  belongs_to :queue,  :class_name => "Training::Queue", :foreign_key => "queue_id",  :inverse_of => :active_jobs
  
  has_one    :event,  :class_name => "Event::Event",    :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'training_active_job'"

  def create_ticker_event
    #create entry for event table
    event = self.build_event(
        character_id: self.queue.settlement.owner_id,   # get current character id
        execute_at: self.finished_active_at,
        event_type: "training_active_job",
        local_event_id: self.id,
    )
    if !self.save  # this is the final step; this makes sure, something is actually executed
      raise ArgumentError.new('could not create event for active training job')
    end
  end
 
end
