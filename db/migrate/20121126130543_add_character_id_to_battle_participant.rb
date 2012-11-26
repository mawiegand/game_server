class AddCharacterIdToBattleParticipant < ActiveRecord::Migration
  def up
    add_column :battle_participants, :character_id, :integer
    add_column :battle_participants, :total_kills, :integer, :default => 0, :null => false
    
    Battle::Participant.all.each do |participant|
      participant.charcter_id = participant.army.owner_id unless participant.army.nil?
      participant.save
    end
  end

  def down
    remove_column :battle_participants, :character_id
    remove_column :battle_participants, :total_kills
  end

end
