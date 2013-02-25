class Fundamental::ArtifactInitiation < ActiveRecord::Base

  belongs_to :artifact, :class_name => "Fundamental::Artifact",   :foreign_key => "artifact_id",    :inverse_of => :initiation

  has_one    :event,    :class_name => "Event::Event",            :foreign_key => "local_event_id", :dependent => :destroy, :conditions => "event_type = 'artifact_initiation'"

  def create_ticker_event
    self.build_event(
      character_id:    self.artifact.owner_id,   # get current character id
      execute_at:      self.finished_at,
      event_type:      "artifact_initiation",
      local_event_id:  self.id,
    )
    raise ArgumentError.new('could not create event for artifact initiation') unless self.save
  end

  def speedup
    unless self.hurried?
      self.hurried = true                                                              # this initiation is hurried
      self.event.destroy                                                               # destroy event
      self.finished_at = self.started_at + (self.finished_at - self.started_at) / 2    # half initiation time
      self.create_ticker_event                                                         # create new ticker event
      self.save
    end
  end

  def finish
    return if artifact.nil?
    artifact.finish_initiation
    self.destroy
  end
end
