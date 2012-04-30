class Military::Battle < ActiveRecord::Base
  
  has_one    :event,        :class_name => "Event::Event",            :foreign_key => "local_event_id"

  has_many   :participants, :class_name => "Military::BattleParticipant", :foreign_key => "battle_id"  
  has_many   :factions,     :class_name => "Military::BattleFaction", :foreign_key => "battle_id"
  has_many   :rounds,       :class_name => "Military::BattleRound",   :foreign_key => "battle_id"
  
  belongs_to :initiator,    :class_name => "Fundamental::Character",  :foreign_key => "initiator_id"
  belongs_to :opponent,     :class_name => "Fundamental::Character",  :foreign_key => "opponent_id"
  
  belongs_to :region,       :class_name => "Map::Region",             :foreign_key => "region_id"
  belongs_to :location,     :class_name => "Map::Location",           :foreign_key => "location_id"
  
end
