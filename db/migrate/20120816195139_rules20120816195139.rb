class Rules20120816195139 < ActiveRecord::Migration
  def change
    add_column :backend_stats,   :resource_stone_amount_sum,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_stone_amount_max,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_stone_production_rate_sum,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_stone_production_rate_max,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_wood_amount_sum,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_wood_amount_max,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_wood_production_rate_sum,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_wood_production_rate_max,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_fur_amount_sum,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_fur_amount_max,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_fur_production_rate_sum,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_fur_production_rate_max,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_cash_amount_sum,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_cash_amount_max,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_cash_production_rate_sum,   :decimal,  {:default=>0.0}    
    add_column :backend_stats,   :resource_cash_production_rate_max,   :decimal,  {:default=>0.0}    
  end
end
