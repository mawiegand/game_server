class Rules20130818182257 < ActiveRecord::Migration
  def change
    add_column :treasure_treasures,   :resource_stone_reward,   :decimal,  {:default=>0.0}    
    add_column :treasure_treasures,   :resource_wood_reward,   :decimal,  {:default=>0.0}    
    add_column :treasure_treasures,   :resource_fur_reward,   :decimal,  {:default=>0.0}    
    add_column :treasure_treasures,   :resource_cash_reward,   :decimal,  {:default=>0.0}    
  end
end
