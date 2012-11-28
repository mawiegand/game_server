class Military::BattleCharacterResults < ActiveRecord::Base
  
  has_one  :battle,     :class_name => "Military::Battle",        :foreign_key => "battle_id",     :inverse_of => :character_results
  has_one  :character,  :class_name => "Fundamental::Character",  :foreign_key => "character_id",  :inverse_of => :battle_results
  # don't reference faction: when faction is deleted, faction_id would be set to nil
  
end
