class Ranking::CharacterRanking < ActiveRecord::Base
  
  belongs_to :character, :class_name => "Fundamental::Character", :foreign_key => "character_id", :inverse_of => :ranking
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id"
  
end
