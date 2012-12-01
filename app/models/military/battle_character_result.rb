class Military::BattleCharacterResult < ActiveRecord::Base

  belongs_to  :battle,     :class_name => "Military::Battle",        :foreign_key => "battle_id",     :inverse_of => :character_results
  belongs_to  :character,  :class_name => "Fundamental::Character",  :foreign_key => "character_id",  :inverse_of => :battle_results
  belongs_to  :faction,    :class_name => "Military::BattleFaction", :foreign_key => "faction_id"
  # don't reference faction: when faction is deleted, faction_id would be set to nil

end
