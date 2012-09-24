class ChangeMundaneRankFromFundamentalCharacter < ActiveRecord::Migration
  def up
    remove_column  :fundamental_characters,   :mundane_rank 
    remove_column  :fundamental_characters,   :sacred_rank 

    add_column     :fundamental_characters,   :mundane_rank,   :integer,  {:default => 0, :null => false}    
    add_column     :fundamental_characters,   :sacred_rank,    :integer,  {:default => 0, :null => false}    
  end

  def down
    remove_column  :fundamental_characters,   :mundane_rank 
    remove_column  :fundamental_characters,   :sacred_rank 

    add_column     :fundamental_characters,   :mundane_rank,   :integer,  {:default => 1, :null => false}    
    add_column     :fundamental_characters,   :sacred_rank,    :integer,  {:default => 1, :null => false}    
  end
end
