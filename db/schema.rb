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

ActiveRecord::Schema.define(:version => 20120414123414) do

  create_table "action_military_move_army_actions", :force => true do |t|
    t.integer  "army_id"
    t.integer  "starting_location_id"
    t.integer  "starting_region_id"
    t.integer  "target_location_id"
    t.integer  "target_region_id"
    t.string   "sender_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "character_id"
    t.datetime "target_reached_at"
    t.integer  "event_id"
    t.integer  "next_action_id"
  end

  create_table "event_events", :force => true do |t|
    t.integer  "character_id"
    t.datetime "execute_at"
    t.string   "event_type"
    t.datetime "locked_at"
    t.string   "locked_by"
    t.integer  "error_code"
    t.integer  "localized_error_description"
    t.datetime "finished_at"
    t.boolean  "blocked"
    t.string   "blocked_by"
    t.string   "localized_blocked_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fundamental_alliance_shouts", :force => true do |t|
    t.integer  "character_id"
    t.integer  "alliance_id"
    t.boolean  "deleted"
    t.boolean  "reported"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fundamental_alliance_shouts", ["alliance_id"], :name => "index_fundamental_alliance_shouts_on_alliance_id"
  add_index "fundamental_alliance_shouts", ["character_id"], :name => "index_fundamental_alliance_shouts_on_character_id"

  create_table "fundamental_alliances", :force => true do |t|
    t.string   "tag"
    t.string   "name"
    t.string   "description"
    t.string   "banner"
    t.integer  "leader_id"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fundamental_characters", :force => true do |t|
    t.string   "identifier"
    t.boolean  "premium_account"
    t.string   "name"
    t.integer  "lvel"
    t.integer  "exp"
    t.integer  "att"
    t.integer  "def"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "health_max"
    t.float    "health_present"
    t.datetime "health_updated_at"
    t.boolean  "locked"
    t.string   "locked_by"
    t.datetime "locked_at"
    t.integer  "skill_points"
    t.integer  "alliance_id"
    t.string   "alliance_tag"
    t.integer  "base_location_id"
    t.integer  "region_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fundamental_guilds", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.string   "description"
    t.string   "logo"
    t.integer  "leader_id"
    t.boolean  "invitation_only"
    t.boolean  "visible"
    t.boolean  "membership_public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "map_locations", :force => true do |t|
    t.integer  "region_id"
    t.integer  "slot"
    t.integer  "type_id"
    t.integer  "level"
    t.integer  "count_markers"
    t.integer  "count_armies"
    t.integer  "owner_id"
    t.string   "owner_name"
    t.integer  "alliance_id"
    t.string   "alliance_tag"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "armies_changed_at"
  end

  add_index "map_locations", ["region_id"], :name => "index_map_locations_on_region_id"
  add_index "map_locations", ["type_id"], :name => "index_map_locations_on_type_id"

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
    t.integer  "count_settlements"
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
    t.integer  "fortress_level"
    t.datetime "armies_changed_at"
    t.integer  "fortress_id"
  end

  add_index "map_regions", ["node_id"], :name => "index_map_regions_on_node_id"

  create_table "military_armies", :force => true do |t|
    t.string   "name"
    t.integer  "home_settlement_id"
    t.string   "home_settlement_name"
    t.integer  "location_id"
    t.integer  "owner_id"
    t.string   "owner_name"
    t.integer  "alliance_id"
    t.string   "alliance_tag"
    t.integer  "ap_max"
    t.integer  "ap_present"
    t.integer  "ap_seconds_per_point"
    t.datetime "ap_last"
    t.integer  "mode"
    t.integer  "stance"
    t.integer  "size_max"
    t.integer  "size_present"
    t.integer  "strength"
    t.integer  "exp"
    t.integer  "rank"
    t.integer  "target_region_id"
    t.integer  "target_location_id"
    t.datetime "target_reached_at"
    t.boolean  "battle_retreat"
    t.integer  "battle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "region_id"
  end

  add_index "military_armies", ["location_id"], :name => "index_military_armies_on_location_id"
  add_index "military_armies", ["owner_id"], :name => "index_military_armies_on_owner_id"
  add_index "military_armies", ["region_id"], :name => "index_military_armies_on_region_id"
  add_index "military_armies", ["target_location_id"], :name => "index_military_armies_on_target_location_id"
  add_index "military_armies", ["target_region_id"], :name => "index_military_armies_on_target_region_id"

end
