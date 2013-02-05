class AddArtifactInitiationLevelToSettlementSettlement < ActiveRecord::Migration
  def change
    add_column :settlement_settlements, :artifact_initiation_level, :integer, :default => 0, :null => false
  end
end
