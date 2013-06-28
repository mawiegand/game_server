class Assignment::SpecialAssignment < ActiveRecord::Base
  
  belongs_to :character,  :class_name => "Fundamental::Character",  :foreign_key => "character_id",  :inverse_of => :special_assignment
  
end
