class Military::BattleParticipant < ActiveRecord::Base

  belongs_to :battle,  :class_name => "Military::Battle",        :foreign_key => "battle_id",  :inverse_of => :participants, :touch => true
  belongs_to :faction, :class_name => "Military::BattleFaction", :foreign_key => "faction_id", :inverse_of => :participants
  belongs_to :army,    :class_name => "Military::Army",          :foreign_key => "army_id",    :inverse_of => :battle_participant

  def has_units?
  	(!army.empty?)
  end

end
