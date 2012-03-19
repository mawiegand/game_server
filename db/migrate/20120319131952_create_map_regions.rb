class CreateMapRegions < ActiveRecord::Migration
  def change
    create_table :map_regions do |t|
      t.integer  :node_id
      t.string   :name
      t.integer  :owner_id
      t.string   :owner_name
      t.integer  :alliance_id
      t.string   :alliance_tag
      t.integer  :count_outposts
      t.integer  :count_settlements
      t.integer  :terrain_id

      t.timestamps
    end
  end
end
