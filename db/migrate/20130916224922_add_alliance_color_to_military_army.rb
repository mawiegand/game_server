class AddAllianceColorToMilitaryArmy < ActiveRecord::Migration
  def change
    add_column :military_armies, :alliance_color, :integer
  end
end
