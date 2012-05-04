class AddColumnVelocityToMilitaryArmy < ActiveRecord::Migration
  def change
    add_column :military_armies, :velocity, :decimal
  end
end
