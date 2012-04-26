class AddApNextToMilitaryArmies < ActiveRecord::Migration
  def change
    add_column    :military_armies, :ap_next, :datetime
    remove_column :military_armies, :ap_last
  end
end
