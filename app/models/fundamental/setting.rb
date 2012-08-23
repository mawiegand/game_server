class Fundamental::Setting < ActiveRecord::Base

  belongs_to :owner, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :settings

end
