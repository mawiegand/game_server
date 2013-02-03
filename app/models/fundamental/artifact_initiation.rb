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
end
