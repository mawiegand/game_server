class AddColumnGarrisonToMilitaryArmy < ActiveRecord::Migration
  def change
    add_column :military_armies, :garrison, :boolean
  end
end
