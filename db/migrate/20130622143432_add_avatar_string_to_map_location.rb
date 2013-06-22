class AddAvatarStringToMapLocation < ActiveRecord::Migration
  def up
    add_column :map_locations,                 :avatar_string, :string
    add_column :map_regions,                   :avatar_string, :string
    add_column :military_armies,               :avatar_string, :string
    add_column :ranking_character_rankings,    :avatar_string, :string
    
    Fundamental::Character.not_deleted.non_npc.each do |character| 
      character.propagate_avatar_string_on_change_only(false)
    end
  end
  
  def down
    remove_column :map_locations,              :avatar_string    
    remove_column :map_regions,                :avatar_string    
    remove_column :military_armies,            :avatar_string    
    remove_column :ranking_character_rankings, :avatar_string    
  end
end
