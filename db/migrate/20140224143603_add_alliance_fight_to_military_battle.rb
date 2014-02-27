class AddAllianceFightToMilitaryBattle < ActiveRecord::Migration
  def change
    add_column :military_battles, :alliance_fight, :boolean, :default => false
  end
end
