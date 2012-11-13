class AddSuspensionEndAtToMilitaryArmy < ActiveRecord::Migration
  def change
    add_column :military_armies, :suspension_ends_at, :datetime
  end
end
