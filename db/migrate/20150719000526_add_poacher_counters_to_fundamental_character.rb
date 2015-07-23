class AddPoacherCountersToFundamentalCharacter < ActiveRecord::Migration
  def up
    add_column :fundamental_characters, :max_poachers_count, :integer
    add_column :fundamental_characters, :spawned_poachers_count, :integer, default: 0

    Fundamental::Character.all.each do |character|
      character.max_poachers_count = character.settlement_points_total * 2
      character.save
    end
  end

  def down
    remove_column :fundamental_characters, :max_poachers_count
    remove_column :fundamental_characters, :spawned_poachers_count
  end
end
