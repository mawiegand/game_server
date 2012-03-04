class CreateMapNodes < ActiveRecord::Migration
  def change
    create_table :map_nodes do |t|
      t.string  :path
      t.decimal :min_x, :default => 0.0
      t.decimal :min_y, :default => 0.0
      t.decimal :max_x, :default => 0.0
      t.decimal :max_y, :default => 0.0
      t.integer :parent_id
      t.boolean :leaf, :default => true
      t.integer :level

      t.timestamps
    end
  end
end
