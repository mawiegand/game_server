class Military::BattleParticipant < ActiveRecord::Base

  belongs_to :battle,  :class_name => "Military::Battle",        :foreign_key => "battle_id",  :inverse_of => :participants, :touch => true
  belongs_to :faction, :class_name => "Military::BattleFaction", :foreign_key => "faction_id", :inverse_of => :participants
  belongs_to :army,    :class_name => "Military::Army",          :foreign_key => "army_id",    :inverse_of => :battle_participant

  def has_units?
  	!self.disbanded? && !army.empty?   # protectd access to army -> in case disbanded is true, there's no army. thus, no units. -> return false
  end

end
