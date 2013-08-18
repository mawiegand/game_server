class Treasure::Treasure < ActiveRecord::Base

  belongs_to :finder,    :class_name => "Fundamental::Character", :foreign_key => "character_id" , :inverse_of => :treasures

end
