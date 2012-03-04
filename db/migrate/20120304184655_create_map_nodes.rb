class CreateMapNodes < ActiveRecord::Migration
  def change
    create_table :map_nodes do |t|
      t.string :path
      t.decimal :min_x
      t.decimal :min_y
      t.decimal :max_x
      t.decimal :max_y
      t.integer :parent_id
      t.boolean :leaf
      t.integer :level

      t.timestamps
    end
  end
end
