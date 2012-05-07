class Military::BattleParticipantResult < ActiveRecord::Base
  
  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id",  :inverse_of => :participant_results
  belongs_to :round, :class_name => "Military::BattleRound", :foreign_key => "round_id", :inverse_of => :faction_results
  belongs_to :faction_result, :class_name => "Military::BattleFactionResult", :foreign_key => "battle_faction_result_id", :inverse_of => :participant_results
  belongs_to :army,    :class_name => "Military::Army",          :foreign_key => "army_id"#,    :inverse_of => :battle_participant_results


end
