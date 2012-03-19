# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120319131952) do

  create_table "map_nodes", :force => true do |t|
    t.string   "path"
    t.decimal  "min_x",               :default => 0.0
    t.decimal  "min_y",               :default => 0.0
    t.decimal  "max_x",               :default => 0.0
    t.decimal  "max_y",               :default => 0.0
    t.integer  "parent_id"
    t.boolean  "leaf",                :default => true
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count_settlementes"
    t.integer  "total_army_strength"
  end

  add_index "map_nodes", ["parent_id"], :name => "index_map_nodes_on_parent_id"
  add_index "map_nodes", ["path"], :name => "index_map_nodes_on_path"

  create_table "map_regions", :force => true do |t|
    t.integer  "node_id"
    t.string   "name"
    t.integer  "owner_id"
    t.string   "owner_name"
    t.integer  "alliance_id"
    t.string   "alliance_tag"
    t.integer  "count_outposts"
    t.integer  "count_settlements"
    t.integer  "terrain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
