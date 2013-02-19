class Rules20130213031248 < ActiveRecord::Migration
  def change
    add_column :fundamental_alliances,   :resource_stone_production_bonus_effects,   :decimal,  {:default=>0.0}    
    add_column :fundamental_alliances,   :resource_wood_production_bonus_effects,   :decimal,  {:default=>0.0}    
    add_column :fundamental_alliances,   :resource_fur_production_bonus_effects,   :decimal,  {:default=>0.0}    
    add_column :fundamental_alliances,   :resource_cash_production_bonus_effects,   :decimal,  {:default=>0.0}    
  end
end
