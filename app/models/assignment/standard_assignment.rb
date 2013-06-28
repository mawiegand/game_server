class Assignment::StandardAssignment < ActiveRecord::Base
  
  belongs_to :character,  :class_name => "Fundamental::Character",  :foreign_key => "character_id",    :inverse_of => :standard_assignments
  has_one    :event,      :class_name => "Event::Event",            :foreign_key => "local_event_id",  :dependent => :destroy, :conditions => "event_type = 'standard_assignment'"
  
  scope :with_type_id,  lambda { |type_id| where(:type_id => type_id) }
  scope :with_type,     lambda { |type|    where(:type_id => type[:id]) }
  
  after_save :manage_event_on_ended_at_change
  
  def self.manage_on_level_change(character, old_level, new_level)
    
    assignment_types = GameRules::Rules.the_rules.assignment_types
    assignment_types.each do |assignment_type|

      if assignment_type[:level] > old_level && assignment_type[:level] <= new_level
        # create corresponding assignment instance
        
        self.create_if_not_existing(character, assignment_type)
        
      elsif assignment_type[:level] <= old_level && assignment_type[:level] > new_level
        # destroy corresponding assignment instance
        
        self.destroy_if_existing(character, assignment_type)
      
      end
    end
  end
  
  def self.create_if_not_existing(character, type)
    assignment = character.standard_assignments.with_type(type)
    if (assignment.nil?)
      assignment = character.standard_assignments.create({
        type_id: type[:id],
      })
    end
    assignment
  end
  
  def self.destroy_if_existing(character, type)
    assignment = character.standard_assignments.with_type(type)
    unless assignment.nil?
      logger.info "Destroying assignment #{type[:id]} for character #{character.id}"
      assignment.destroy
    end
  end
  
  # returns the assignment type from the rules that corresponds to this assignment
  def assignment_type
    GameRules::Rules.the_rules.assignment_types[self.type_id || 0]
  end
  
  # halves the duration of an ongoing assignment
  def speedup_now
    return         if self.started_at.nil?
    
    self.endet_at  = self.started_at.advance(:seconds => (self.assignment_type[:duration]).to_i / 2)
    self.halved_at = DateTime.now 
    self.halved_count += 1
  end
    
  # starts the assignment now, uses the duration as specified in the 
  # game rules and sets the start and end time appropriately
  def start_now
    return         if !self.started_at.nil?
    
    self.started_at = DateTime.now
    self.halved_at  = nil
    self.ended_at   = self.started_at.advance(:seconds => (self.assignment_type[:duration]).to_i)
    self.execution_count += 1
  end

  # creates an event for the ongoing assignment
  def create_event
    if event.nil?
      event = self.build_event(
          character_id:   self.character_id,   # get current character id
          execute_at:     self.ended_at,
          event_type:     "standard_assignment",
          local_event_id: self.id,
      )
      if !self.save  # this is the final step; this makes sure, something is actually executed
        raise ArgumentError.new('could not create event for active training job')
      end
    end
    self.event
  end
  
  # updates the end time of the event corresponding to the ongoing assignment
  def update_event
    if self.event.nil?
      create_event  unless self.ended_at.nil?
    elsif self.ended_at == nil
      self.event.destroy
    else
      self.event.execute_at = self.ended_at
      self.event.save
    end
    event
  end
  
  
  
  protected
  
    def manage_event_on_ended_at_change
      return true    unless ended_at_changed?
      update_event
      true
    end
  
end
