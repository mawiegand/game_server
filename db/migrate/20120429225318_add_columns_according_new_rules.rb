class AddColumnsAccordingNewRules < ActiveRecord::Migration
  def change
    add_column :military_army_details,   :unit_thrower,   :integer
    add_column :military_army_details,   :unit_skewer,   :integer
    add_column :military_army_details,   :unit_light_cavalry,   :integer
  end
end
