class Military::BattleFactionResult < ActiveRecord::Base
  
  
  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id",  :inverse_of => :factions_results
  belongs_to :round, :class_name => "Military::BattleRound", :foreign_key => "round_id", :inverse_of => :faction_results
  belongs_to :faction, :class_name => "Military::BattleFaction", :foreign_key => "faction_id", :inverse_of => :faction_results

  has_many   :participant_results, :class_name => "Military::BattleParticipantResult", :foreign_key => "battle_faction_result_id", :inverse_of => :faction_result

  
end
