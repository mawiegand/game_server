class ChangeDefaultToMapRegion < ActiveRecord::Migration

  def up

    # need to do this BEFORE setting the not-null constraint
    Map::Region.update_all("count_settlements = 0, count_outposts = 0")
    
    change_column :map_regions, :count_settlements, :integer, default: 0, null: false
    change_column :map_regions, :count_outposts,    :integer, default: 0, null: false
  end

  def down
    change_column :map_regions, :count_settlements, :integer, default: nil, null: true
    change_column :map_regions, :count_outposts,    :integer, default: nil, null: true
  end
end
