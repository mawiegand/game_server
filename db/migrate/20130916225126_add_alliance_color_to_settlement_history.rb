class AddAllianceColorToSettlementHistory < ActiveRecord::Migration
  def change
    add_column :settlement_histories, :alliance_color, :integer
  end
end
