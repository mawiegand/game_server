class AddNotifiedMundaneRankToFundamentalCharacter < ActiveRecord::Migration
  def up
    add_column :fundamental_characters, :notified_mundane_rank, :integer, :default => 0, :null => false
    add_column :fundamental_characters, :notified_sacred_rank,  :integer, :default => 0, :null => false
    add_column :fundamental_characters, :staff_roles, :string
    
    Fundamental::Character.all.each do |character|
      character.notified_mundane_rank = character.mundane_rank
      character.notified_sacred_rank = character.sacred_rank
      character.save
    end
  end
  
  def down 
    remove_column :fundamental_characters, :notified_mundane_rank
    remove_column :fundamental_characters, :notified_sacred_rank
    remove_column :fundamental_characters, :staff_roles
  end
end
