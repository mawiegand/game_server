class AddFulfillmentRatioToFundamentalVictoryProgress < ActiveRecord::Migration
  def change
    add_column :fundamental_victory_progresses, :fulfillment_ratio, :decimal, :default => 0.0, :null => false
  end
end
