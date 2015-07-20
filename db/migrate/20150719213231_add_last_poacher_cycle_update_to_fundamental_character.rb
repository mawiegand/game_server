class AddLastPoacherCycleUpdateToFundamentalCharacter < ActiveRecord::Migration
  def up
    add_column :fundamental_characters, :last_poacher_cycle_update, :datetime

    Fundamental::Character.all.each do |character|
      character.update_poachers
    end
  end

  def down
    Event::Event.where(event_type: 'spawn_poacher').destroy_all

    remove_column :fundamental_characters, :last_poacher_cycle_update
  end
end
