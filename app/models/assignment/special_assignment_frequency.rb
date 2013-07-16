class Assignment::SpecialAssignmentFrequency < ActiveRecord::Base

  scope :find_by_character, lambda { |character| where(:character_id => character.id) }

end
