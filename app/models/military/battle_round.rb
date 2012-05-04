class Military::BattleRound < ActiveRecord::Base
  
  belongs_to :battle, :class_name => "Military::Battle", :foreign_key => "battle_id", :counter_cache => true
 
  has_many   :faction_results, :class_name => "Military::BattleFactionResult", :foreign_key => "round_id"

end
