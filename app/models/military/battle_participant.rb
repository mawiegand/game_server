class Military::BattleParticipant < ActiveRecord::Base

  belongs_to :battle,    :class_name => "Military::Battle",        :foreign_key => "battle_id",    :inverse_of => :participants, :touch => true
  belongs_to :faction,   :class_name => "Military::BattleFaction", :foreign_key => "faction_id",   :inverse_of => :participants
  belongs_to :army,      :class_name => "Military::Army",          :foreign_key => "army_id",      :inverse_of => :battle_participant
  belongs_to :character, :class_name => "Fundamental::Character",  :foreign_key => "character_id"
  has_many   :results,   :class_name => "Military::BattleParticipantResult", :foreign_key => "participant_id", :inverse_of => :participant, :order => 'round_id ASC'

  def has_units?
  	!self.disbanded? && !army.empty?   # protectd access to army -> in case disbanded is true, there's no army. thus, no units. -> return false
  end

end
