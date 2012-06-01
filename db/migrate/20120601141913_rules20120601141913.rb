class Rules20120601141913 < ActiveRecord::Migration
  def change
    add_column :settlement_settlements,   :settlement_queue_buildings_unlock_count,   :integer, :options => {:default=>0}    
    add_column :settlement_settlements,   :settlement_queue_fortifications_unlock_count,   :integer, :options => {:default=>0}    
    add_column :settlement_settlements,   :settlement_queue_infantry_unlock_count,   :integer, :options => {:default=>0}    
    add_column :fundamental_characters,   :character_queue_research_unlock_count,   :integer, :options => {:default=>0}    
    add_column :fundamental_alliances,   :alliance_queue_alliance_research_unlock_count,   :integer, :options => {:default=>0}    
  end
end
