class AddInvisibleToMilitaryArmy < ActiveRecord::Migration
  def change
    add_column :military_armies, :invisible, :boolean, :default => false
  end
end
