class Military::BattleRound < ActiveRecord::Base
  
  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id", :counter_cache => true, :touch => true
 
  has_many   :faction_results, :class_name => "Military::BattleFactionResult", :foreign_key => "round_id", :inverse_of => :round
  has_many   :participant_results, :class_name => "Military::BattleParticipantResult", :foreign_key => "round_id", :inverse_of => :round

end
