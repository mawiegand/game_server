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

ActiveRecord::Schema.define(:version => 20120606143023) do

  create_table "action_military_attack_army_actions", :force => true do |t|
    t.integer  "attacker_id"
    t.integer  "defender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "backend_users", :force => true do |t|
    t.string   "email"
    t.string   "salt"
    t.string   "encrypted_password"
    t.boolean  "admin"
    t.boolean  "staff"
    t.string   "firstname"
    t.string   "surname"
    t.string   "login"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "construction_active_jobs", :force => true do |t|
    t.integer  "queue_id"
    t.integer  "job_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.float    "progress",    :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "construction_jobs", :force => true do |t|
    t.integer  "queue_id"
    t.integer  "slot_id"
    t.integer  "position"
    t.string   "job_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "building_id"
    t.integer  "level_after"
  end

  create_table "construction_queues", :force => true do |t|
    t.integer  "settlement_id"
    t.integer  "type_id"
    t.decimal  "speed",             :default => 0.0
    t.integer  "max_length"
    t.integer  "threads"
    t.integer  "jobs_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "speedup_buildings", :default => 0.0
    t.decimal  "speedup_sciences",  :default => 0.0
    t.decimal  "speedup_alliance",  :default => 0.0
    t.decimal  "speedup_effects",   :default => 0.0
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
    t.integer  "local_event_id"
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
  add_index "fundamental_alliance_shouts", ["created_at"], :name => "index_fundamental_alliance_shouts_on_created_at"

  create_table "fundamental_alliances", :force => true do |t|
    t.string   "tag"
    t.string   "name"
    t.string   "description"
    t.string   "banner"
    t.integer  "leader_id"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "alliance_queue_alliance_research_unlock_count", :default => 0
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
    t.integer  "base_region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "base_node_id"
    t.integer  "frog_amount",                           :default => 0
    t.datetime "premium_expiration"
    t.integer  "character_queue_research_unlock_count", :default => 0
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
    t.integer  "settlement_type_id"
    t.integer  "settlement_level"
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
    t.integer  "right_of_way"
  end

  add_index "map_locations", ["region_id"], :name => "index_map_locations_on_region_id"
  add_index "map_locations", ["settlement_type_id"], :name => "index_map_locations_on_type_id"

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
    t.integer  "settlement_level"
    t.datetime "armies_changed_at"
    t.integer  "fortress_id"
    t.integer  "settlement_type_id"
  end

  add_index "map_regions", ["node_id"], :name => "index_map_regions_on_node_id"

  create_table "messaging_archive_entries", :force => true do |t|
    t.integer  "archivebox_id"
    t.integer  "owner_id"
    t.integer  "message_id"
    t.integer  "sender_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messaging_archives", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "messages_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messaging_inbox_entries", :force => true do |t|
    t.integer  "inbox_id"
    t.integer  "owner_id"
    t.integer  "message_id"
    t.integer  "sender_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messaging_inboxes", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "messages_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messaging_messages", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.integer  "type_id"
    t.string   "subject"
    t.string   "body"
    t.datetime "send_at"
    t.boolean  "reported"
    t.integer  "reporter_id"
    t.integer  "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messaging_outbox_entries", :force => true do |t|
    t.integer  "outbox_id"
    t.integer  "owner_id"
    t.integer  "message_id"
    t.integer  "recipient_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messaging_outboxes", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "messages_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.datetime "ap_next"
    t.boolean  "garrison"
    t.decimal  "velocity"
    t.decimal  "unitcategory_infantry_strength"
    t.decimal  "unitcategory_cavalry_strength"
    t.decimal  "unitcategory_artillery_strength"
    t.integer  "kills"
    t.integer  "victories"
    t.decimal  "unitcategory_siege_strength"
  end

  add_index "military_armies", ["location_id"], :name => "index_military_armies_on_location_id"
  add_index "military_armies", ["owner_id"], :name => "index_military_armies_on_owner_id"
  add_index "military_armies", ["region_id"], :name => "index_military_armies_on_region_id"
  add_index "military_armies", ["target_location_id"], :name => "index_military_armies_on_target_location_id"
  add_index "military_armies", ["target_region_id"], :name => "index_military_armies_on_target_region_id"

  create_table "military_army_details", :force => true do |t|
    t.integer  "army_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unit_thrower"
    t.integer  "unit_skewer"
    t.integer  "unit_light_cavalry"
    t.integer  "unit_tree_huggers"
    t.integer  "unit_sabre_riders"
    t.integer  "unit_squirrel_hunters"
    t.integer  "unit_clubbers"
    t.integer  "unit_catapult"
    t.integer  "unit_ram"
  end

  create_table "military_battle_faction_results", :force => true do |t|
    t.integer  "battle_id"
    t.integer  "round_id"
    t.integer  "faction_id"
    t.integer  "leader_id"
    t.string   "given_command"
    t.string   "executed_command"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "military_battle_factions", :force => true do |t|
    t.integer  "battle_id"
    t.integer  "faction_num"
    t.integer  "leader_id"
    t.datetime "joined_at"
    t.string   "present_command"
    t.integer  "total_casualties"
    t.integer  "total_kills"
    t.decimal  "total_damage_inflicted"
    t.decimal  "total_damage_taken"
    t.integer  "total_hitpoints"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "unitcategory_infantry_strength"
    t.decimal  "unitcategory_cavalry_strength"
    t.decimal  "unitcategory_artillery_strength"
    t.decimal  "unitcategory_siege_strength"
  end

  create_table "military_battle_participant_results", :force => true do |t|
    t.integer  "battle_id"
    t.integer  "round_id"
    t.integer  "army_id"
    t.integer  "battle_faction_result_id"
    t.boolean  "retreat_tried"
    t.boolean  "retreat_succeeded"
    t.integer  "kills"
    t.integer  "experience_gained"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unit_thrower"
    t.integer  "unit_thrower_casualties"
    t.decimal  "unit_thrower_damage_taken"
    t.decimal  "unit_thrower_damage_inflicted"
    t.integer  "unit_skewer"
    t.integer  "unit_skewer_casualties"
    t.decimal  "unit_skewer_damage_taken"
    t.decimal  "unit_skewer_damage_inflicted"
    t.integer  "unit_light_cavalry"
    t.integer  "unit_light_cavalry_casualties"
    t.decimal  "unit_light_cavalry_damage_taken"
    t.decimal  "unit_light_cavalry_damage_inflicted"
    t.integer  "unit_tree_huggers"
    t.integer  "unit_tree_huggers_casualties"
    t.decimal  "unit_tree_huggers_damage_taken"
    t.decimal  "unit_tree_huggers_damage_inflicted"
    t.integer  "unit_sabre_riders"
    t.integer  "unit_sabre_riders_casualties"
    t.decimal  "unit_sabre_riders_damage_taken"
    t.decimal  "unit_sabre_riders_damage_inflicted"
    t.integer  "unit_squirrel_hunters"
    t.integer  "unit_squirrel_hunters_casualties"
    t.decimal  "unit_squirrel_hunters_damage_taken"
    t.decimal  "unit_squirrel_hunters_damage_inflicted"
    t.integer  "unit_clubbers"
    t.integer  "unit_clubbers_casualties"
    t.decimal  "unit_clubbers_damage_taken"
    t.decimal  "unit_clubbers_damage_inflicted"
    t.integer  "unit_catapult"
    t.integer  "unit_catapult_casualties"
    t.decimal  "unit_catapult_damage_taken"
    t.decimal  "unit_catapult_damage_inflicted"
    t.integer  "unit_ram"
    t.integer  "unit_ram_casualties"
    t.decimal  "unit_ram_damage_taken"
    t.decimal  "unit_ram_damage_inflicted"
  end

  create_table "military_battle_participants", :force => true do |t|
    t.integer  "army_id"
    t.integer  "battle_id"
    t.integer  "faction_id"
    t.datetime "joined_at"
    t.boolean  "retreat"
    t.integer  "retreat_to_region_id"
    t.integer  "retreat_to_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "military_battle_rounds", :force => true do |t|
    t.integer  "battle_id"
    t.integer  "round_num"
    t.datetime "executed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "military_battles", :force => true do |t|
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "next_round_at"
    t.integer  "initiator_id"
    t.integer  "opponent_id"
    t.integer  "location_id"
    t.integer  "region_id"
    t.integer  "importance_rating"
    t.integer  "decisiveness"
    t.integer  "battle_factions_count"
    t.integer  "battle_rounds_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settlement_histories", :force => true do |t|
    t.integer  "settlement_id"
    t.string   "event_type"
    t.integer  "owner_id"
    t.string   "owner_name"
    t.integer  "alliance_id"
    t.string   "alliance_tag"
    t.integer  "level"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settlement_settlements", :force => true do |t|
    t.integer  "type_id"
    t.integer  "region_id"
    t.integer  "location_id"
    t.integer  "node_id"
    t.integer  "owner_id"
    t.integer  "alliance_id"
    t.integer  "level"
    t.datetime "founded_at"
    t.decimal  "defense_bonus"
    t.decimal  "morale"
    t.decimal  "tax_rate"
    t.boolean  "owns_region"
    t.boolean  "taxable"
    t.integer  "command_points"
    t.integer  "armies_count"
    t.integer  "garrison_id"
    t.boolean  "besieged"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
    t.integer  "founder_id"
    t.integer  "settlement_queue_buildings_unlock_count",      :default => 0
    t.integer  "settlement_queue_fortifications_unlock_count", :default => 0
    t.integer  "settlement_queue_infantry_unlock_count",       :default => 0
  end

  create_table "settlement_slots", :force => true do |t|
    t.integer  "settlement_id"
    t.integer  "slot_num"
    t.string   "type"
    t.integer  "max_level"
    t.integer  "building_id"
    t.integer  "level"
    t.integer  "construction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_offers", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "price"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_transactions", :force => true do |t|
    t.integer  "character_id"
    t.integer  "credit_amount_booked"
    t.integer  "credit_amount_before"
    t.integer  "credit_amount_after"
    t.string   "offer"
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
