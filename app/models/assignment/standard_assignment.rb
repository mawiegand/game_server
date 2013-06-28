class Assignment::StandardAssignment < ActiveRecord::Base
  
  belongs_to :character,  :class_name => "Fundamental::Character",  :foreign_key => "character_id",  :inverse_of => :standard_assignments
  
  scope :with_type_id,  lambda { |type_id| where(:type_id => type_id) }
  scope :with_type,     lambda { |type|    where(:type_id => type[:id]) }
  
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
  
  
end
