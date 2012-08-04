class AddFortressCountToFundamentalCharacter < ActiveRecord::Migration
  def up
    add_column :fundamental_characters, :fortress_count, :integer, :default => 0, :null => false
    
    Fundamental::Character.all.each do |character| 
      character.fortress_count = character.fortresses.count
      character.save
    end
  end
  
  def down
    remove_column :fundamental_characters, :fortress_count
  end
end
