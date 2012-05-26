class RemoveColumnFounderIdFromSettlementSettlement < ActiveRecord::Migration
  def up
    change_column :settlement_settlements, :founder_id, :integer
  end
  
  def down
    change_column :settlement_settlements, :founder_id, :datetime    
  end
end
