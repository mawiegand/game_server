class AddApRateToMilitaryArmy < ActiveRecord::Migration
  def change
    add_column :military_armies, :ap_rate, :decimal, :default => 1.0, :null => false
  end
end
