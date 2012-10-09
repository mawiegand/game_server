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

ActiveRecord::Schema.define(:version => 20121009230254) do

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

  create_table "action_trading_trading_carts_actions", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "starting_region_id"
    t.integer  "target_region_id"
    t.boolean  "returning"
    t.datetime "target_reached_at"
    t.datetime "returned_at"
    t.integer  "num_carts"
    t.integer  "event_id"
    t.string   "sender_ip"
    t.integer  "starting_settlement_id"
    t.integer  "target_settlement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resource_stone_amount"
    t.integer  "resource_wood_amount"
    t.integer  "resource_fur_amount"
    t.integer  "resource_cash_amount"
  end

  create_table "backend_browser_stats", :force => true do |t|
    t.string   "identifier"
    t.boolean  "success"
    t.string   "user_agent"
    t.text     "modernizr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backend_stats", :force => true do |t|
    t.integer  "new_users"
    t.integer  "dau"
    t.integer  "wau"
    t.integer  "mau"
    t.integer  "active_users"
    t.decimal  "churn_today"
    t.decimal  "churn_week"
    t.decimal  "churn_month"
    t.integer  "dac"
    t.integer  "wac"
    t.integer  "mac"
    t.integer  "du"
    t.integer  "wu"
    t.integer  "mu"
    t.integer  "dc"
    t.integer  "wc"
    t.integer  "mc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dnu"
    t.integer  "wnu"
    t.integer  "mnu"
    t.integer  "total_users"
    t.integer  "total_customers"
    t.integer  "active_customers"
    t.integer  "dlu"
    t.integer  "wlu"
    t.integer  "mlu"
    t.decimal  "resource_stone_amount_sum",          :default => 0.0
    t.decimal  "resource_stone_amount_max",          :default => 0.0
    t.decimal  "resource_stone_production_rate_sum", :default => 0.0
    t.decimal  "resource_stone_production_rate_max", :default => 0.0
    t.decimal  "resource_wood_amount_sum",           :default => 0.0
    t.decimal  "resource_wood_amount_max",           :default => 0.0
    t.decimal  "resource_wood_production_rate_sum",  :default => 0.0
    t.decimal  "resource_wood_production_rate_max",  :default => 0.0
    t.decimal  "resource_fur_amount_sum",            :default => 0.0
    t.decimal  "resource_fur_amount_max",            :default => 0.0
    t.decimal  "resource_fur_production_rate_sum",   :default => 0.0
    t.decimal  "resource_fur_production_rate_max",   :default => 0.0
    t.decimal  "resource_cash_amount_sum",           :default => 0.0
    t.decimal  "resource_cash_amount_max",           :default => 0.0
    t.decimal  "resource_cash_production_rate_sum",  :default => 0.0
    t.decimal  "resource_cash_production_rate_max",  :default => 0.0
    t.integer  "month_num_registered",               :default => 0,   :null => false
    t.integer  "month_num_logged_in_once",           :default => 0,   :null => false
    t.integer  "month_num_logged_in_two_days",       :default => 0,   :null => false
    t.integer  "month_num_active",                   :default => 0,   :null => false
    t.integer  "month_num_long_term_active",         :default => 0,   :null => false
    t.integer  "month_num_paying",                   :default => 0,   :null => false
    t.integer  "day_num_registered",                 :default => 0,   :null => false
    t.integer  "day_num_logged_in_once",             :default => 0,   :null => false
    t.integer  "day_num_logged_in_two_days",         :default => 0,   :null => false
    t.integer  "day_num_active",                     :default => 0,   :null => false
    t.integer  "day_num_long_term_active",           :default => 0,   :null => false
    t.integer  "day_num_paying",                     :default => 0,   :null => false
    t.integer  "month_credits_spent",                :default => 0,   :null => false
    t.integer  "day_credits_spent",                  :default => 0,   :null => false
    t.integer  "dcs",                                :default => 0,   :null => false
    t.integer  "mcs",                                :default => 0,   :null => false
    t.integer  "wcs",                                :default => 0,   :null => false
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
    t.integer  "level_before", :default => 0
  end

  create_table "construction_queues", :force => true do |t|
    t.integer  "settlement_id"
    t.integer  "type_id"
    t.decimal  "speed",             :default => 0.0
    t.integer  "threads"
    t.integer  "jobs_count",        :default => 0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "speedup_buildings", :default => 0.0, :null => false
    t.decimal  "speedup_sciences",  :default => 0.0, :null => false
    t.decimal  "speedup_alliance",  :default => 0.0, :null => false
    t.decimal  "speedup_effects",   :default => 0.0, :null => false
  end

  create_table "effect_resource_effects", :force => true do |t|
    t.integer  "resource_id"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_id"
    t.decimal  "bonus"
    t.integer  "resource_pool_id"
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
    t.integer  "members_count"
  end

  create_table "fundamental_announcements", :force => true do |t|
    t.integer  "original_id"
    t.string   "locale"
    t.string   "heading"
    t.text     "body"
    t.datetime "expires"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",      :default => true, :null => false
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
    t.datetime "premium_expiration"
    t.integer  "character_queue_research_unlock_count",    :default => 0
    t.integer  "character_unlock_diplomacy_count",         :default => 0
    t.integer  "character_unlock_alliance_creation_count", :default => 0
    t.integer  "score"
    t.boolean  "npc",                                      :default => false, :null => false
    t.integer  "name_change_count",                        :default => 0,     :null => false
    t.integer  "login_count",                              :default => 0,     :null => false
    t.datetime "last_login_at"
    t.integer  "fortress_count",                           :default => 0,     :null => false
    t.datetime "last_request_at"
    t.string   "max_conversion_state"
    t.integer  "settlement_points_total",                  :default => 1,     :null => false
    t.integer  "settlement_points_used",                   :default => 0,     :null => false
    t.integer  "mundane_rank",                             :default => 0,     :null => false
    t.integer  "sacred_rank",                              :default => 0,     :null => false
    t.string   "gender"
    t.integer  "gender_change_count",                      :default => 0,     :null => false
    t.datetime "reached_game"
    t.integer  "credits_spent_total",                      :default => 0,     :null => false
    t.boolean  "banned"
    t.string   "ban_reason"
    t.datetime "ban_ended_at"
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

  create_table "fundamental_resource_pools", :force => true do |t|
    t.integer  "character_id"
    t.datetime "locked_at"
    t.string   "locked_by"
    t.string   "locked_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "productionUpdatedAt"
    t.decimal  "resource_wood_amount",                    :default => 0.0
    t.decimal  "resource_wood_capacity",                  :default => 0.0
    t.decimal  "resource_wood_production_rate",           :default => 0.0
    t.decimal  "resource_stone_amount",                   :default => 0.0
    t.decimal  "resource_stone_capacity",                 :default => 0.0
    t.decimal  "resource_stone_production_rate",          :default => 0.0
    t.decimal  "resource_fur_amount",                     :default => 0.0
    t.decimal  "resource_fur_capacity",                   :default => 0.0
    t.decimal  "resource_fur_production_rate",            :default => 0.0
    t.decimal  "resource_cash_amount",                    :default => 0.0
    t.decimal  "resource_cash_capacity",                  :default => 0.0
    t.decimal  "resource_cash_production_rate",           :default => 0.0
    t.decimal  "resource_wood_production_bonus_effects",  :default => 0.0
    t.decimal  "resource_stone_production_bonus_effects", :default => 0.0
    t.decimal  "resource_fur_production_bonus_effects",   :default => 0.0
    t.decimal  "resource_cash_production_bonus_effects",  :default => 0.0
  end

  create_table "fundamental_settings", :force => true do |t|
    t.boolean  "email_messages", :default => true, :null => false
    t.integer  "character_id"
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
    t.integer  "settlement_score",   :default => 0, :null => false
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
    t.integer  "settlement_score",   :default => 0, :null => false
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
    t.boolean  "read",       :default => false, :null => false
  end

  create_table "messaging_inboxes", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "messages_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unread_messages_count"
  end

  create_table "messaging_jabber_commands", :force => true do |t|
    t.integer  "character_id"
    t.string   "command"
    t.string   "room"
    t.string   "data"
    t.datetime "blocked_at"
    t.string   "blocked_by"
    t.boolean  "processed",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messaging_messages", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.integer  "type_id"
    t.string   "subject"
    t.text     "body"
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
    t.boolean  "removed",                         :default => false, :null => false
    t.boolean  "npc",                             :default => false, :null => false
    t.decimal  "unitcategory_special_strength",   :default => 0.0,   :null => false
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
    t.integer  "unit_neanderthal"
    t.integer  "unit_slingshot_warrior"
    t.integer  "unit_babysaurus"
    t.integer  "unit_little_chief"
    t.integer  "unit_clubbers_2"
    t.integer  "unit_clubbers_3"
    t.integer  "unit_thrower_2"
    t.integer  "unit_thrower_3"
    t.integer  "unit_thrower_4"
    t.integer  "unit_light_cavalry_2"
    t.integer  "unit_light_cavalry_3"
    t.integer  "unit_light_cavalry_4"
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
    t.decimal  "unitcategory_special_strength",   :default => 0.0, :null => false
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
    t.integer  "unit_neanderthal"
    t.integer  "unit_neanderthal_casualties"
    t.decimal  "unit_neanderthal_damage_taken"
    t.decimal  "unit_neanderthal_damage_inflicted"
    t.integer  "unit_slingshot_warrior"
    t.integer  "unit_slingshot_warrior_casualties"
    t.decimal  "unit_slingshot_warrior_damage_taken"
    t.decimal  "unit_slingshot_warrior_damage_inflicted"
    t.integer  "unit_babysaurus"
    t.integer  "unit_babysaurus_casualties"
    t.decimal  "unit_babysaurus_damage_taken"
    t.decimal  "unit_babysaurus_damage_inflicted"
    t.integer  "unit_little_chief"
    t.integer  "unit_little_chief_casualties"
    t.decimal  "unit_little_chief_damage_taken"
    t.decimal  "unit_little_chief_damage_inflicted"
    t.integer  "unit_clubbers_2"
    t.integer  "unit_clubbers_2_casualties"
    t.decimal  "unit_clubbers_2_damage_taken"
    t.decimal  "unit_clubbers_2_damage_inflicted"
    t.integer  "unit_clubbers_3"
    t.integer  "unit_clubbers_3_casualties"
    t.decimal  "unit_clubbers_3_damage_taken"
    t.decimal  "unit_clubbers_3_damage_inflicted"
    t.integer  "unit_thrower_2"
    t.integer  "unit_thrower_2_casualties"
    t.decimal  "unit_thrower_2_damage_taken"
    t.decimal  "unit_thrower_2_damage_inflicted"
    t.integer  "unit_thrower_3"
    t.integer  "unit_thrower_3_casualties"
    t.decimal  "unit_thrower_3_damage_taken"
    t.decimal  "unit_thrower_3_damage_inflicted"
    t.integer  "unit_thrower_4"
    t.integer  "unit_thrower_4_casualties"
    t.decimal  "unit_thrower_4_damage_taken"
    t.decimal  "unit_thrower_4_damage_inflicted"
    t.integer  "unit_light_cavalry_2"
    t.integer  "unit_light_cavalry_2_casualties"
    t.decimal  "unit_light_cavalry_2_damage_taken"
    t.decimal  "unit_light_cavalry_2_damage_inflicted"
    t.integer  "unit_light_cavalry_3"
    t.integer  "unit_light_cavalry_3_casualties"
    t.decimal  "unit_light_cavalry_3_damage_taken"
    t.decimal  "unit_light_cavalry_3_damage_inflicted"
    t.integer  "unit_light_cavalry_4"
    t.integer  "unit_light_cavalry_4_casualties"
    t.decimal  "unit_light_cavalry_4_damage_taken"
    t.decimal  "unit_light_cavalry_4_damage_inflicted"
  end

  create_table "military_battle_participants", :force => true do |t|
    t.integer  "army_id"
    t.integer  "battle_id"
    t.integer  "faction_id"
    t.datetime "joined_at"
    t.boolean  "retreated"
    t.integer  "retreated_to_region_id"
    t.integer  "retreated_to_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_experience_gained",  :default => 0, :null => false
    t.boolean  "disbanded"
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
    t.boolean  "removed",               :default => false, :null => false
    t.integer  "message_id"
  end

  create_table "ranking_alliance_rankings", :force => true do |t|
    t.integer  "alliance_id"
    t.string   "alliance_tag"
    t.integer  "overall_score",    :default => 0, :null => false
    t.integer  "overall_rank"
    t.integer  "resource_score",   :default => 0, :null => false
    t.integer  "resource_rank"
    t.integer  "power_score",      :default => 0, :null => false
    t.integer  "power_rank"
    t.integer  "num_settlements",  :default => 0, :null => false
    t.integer  "settlements_rank"
    t.integer  "num_outposts",     :default => 0, :null => false
    t.integer  "outposts_rank"
    t.integer  "num_fortress",     :default => 0, :null => false
    t.integer  "fortress_rank"
    t.integer  "num_members",      :default => 0, :null => false
    t.integer  "members_rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranking_character_rankings", :force => true do |t|
    t.integer  "character_id"
    t.string   "character_name"
    t.integer  "alliance_id"
    t.string   "alliance_tag"
    t.integer  "overall_score",            :default => 0, :null => false
    t.integer  "overall_rank"
    t.integer  "resource_score",           :default => 0, :null => false
    t.integer  "resource_rank"
    t.integer  "power_score",              :default => 0, :null => false
    t.integer  "power_rank"
    t.integer  "num_settlements",          :default => 0, :null => false
    t.integer  "settlements_rank"
    t.integer  "num_outposts",             :default => 0, :null => false
    t.integer  "outposts_rank"
    t.integer  "num_fortress",             :default => 0, :null => false
    t.integer  "fortress_rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_experience",           :default => 0, :null => false
    t.integer  "max_experience_rank"
    t.string   "max_experience_army_name"
    t.integer  "max_experience_army_rank"
    t.integer  "max_experience_army_id"
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
    t.integer  "settlement_queue_buildings_unlock_count",        :default => 0
    t.integer  "settlement_queue_fortifications_unlock_count",   :default => 0
    t.integer  "settlement_queue_infantry_unlock_count",         :default => 0
    t.decimal  "resource_wood_capacity",                         :default => 0.0
    t.decimal  "resource_wood_production_rate",                  :default => 0.0
    t.decimal  "resource_wood_base_production",                  :default => 0.0
    t.decimal  "resource_wood_production_bonus",                 :default => 0.0
    t.decimal  "resource_wood_production_bonus_buildings",       :default => 0.0
    t.decimal  "resource_wood_production_bonus_sciences",        :default => 0.0
    t.decimal  "resource_wood_production_bonus_alliance",        :default => 0.0
    t.decimal  "resource_wood_production_bonus_effects",         :default => 0.0
    t.decimal  "resource_stone_capacity",                        :default => 0.0
    t.decimal  "resource_stone_production_rate",                 :default => 0.0
    t.decimal  "resource_stone_base_production",                 :default => 0.0
    t.decimal  "resource_stone_production_bonus",                :default => 0.0
    t.decimal  "resource_stone_production_bonus_buildings",      :default => 0.0
    t.decimal  "resource_stone_production_bonus_sciences",       :default => 0.0
    t.decimal  "resource_stone_production_bonus_alliance",       :default => 0.0
    t.decimal  "resource_stone_production_bonus_effects",        :default => 0.0
    t.decimal  "resource_fur_capacity",                          :default => 0.0
    t.decimal  "resource_fur_production_rate",                   :default => 0.0
    t.decimal  "resource_fur_base_production",                   :default => 0.0
    t.decimal  "resource_fur_production_bonus",                  :default => 0.0
    t.decimal  "resource_fur_production_bonus_buildings",        :default => 0.0
    t.decimal  "resource_fur_production_bonus_sciences",         :default => 0.0
    t.decimal  "resource_fur_production_bonus_alliance",         :default => 0.0
    t.decimal  "resource_fur_production_bonus_effects",          :default => 0.0
    t.decimal  "resource_cash_capacity",                         :default => 0.0
    t.decimal  "resource_cash_production_rate",                  :default => 0.0
    t.decimal  "resource_cash_base_production",                  :default => 0.0
    t.decimal  "resource_cash_production_bonus",                 :default => 0.0
    t.decimal  "resource_cash_production_bonus_buildings",       :default => 0.0
    t.decimal  "resource_cash_production_bonus_sciences",        :default => 0.0
    t.decimal  "resource_cash_production_bonus_alliance",        :default => 0.0
    t.decimal  "resource_cash_production_bonus_effects",         :default => 0.0
    t.string   "name",                                           :default => "Settlement", :null => false
    t.integer  "settlement_unlock_garrison_count",               :default => 0
    t.string   "alliance_tag"
    t.integer  "score"
    t.decimal  "resource_wood_production_bonus_global_effects",  :default => 0.0
    t.decimal  "resource_stone_production_bonus_global_effects", :default => 0.0
    t.decimal  "resource_fur_production_bonus_global_effects",   :default => 0.0
    t.decimal  "resource_cash_production_bonus_global_effects",  :default => 0.0
    t.integer  "settlement_unlock_diplomacy_count",              :default => 0
    t.integer  "settlement_unlock_alliance_creation_count",      :default => 0
    t.integer  "settlement_queue_artillery_unlock_count",        :default => 0
    t.integer  "settlement_queue_cavalry_unlock_count",          :default => 0
    t.integer  "settlement_queue_siege_unlock_count",            :default => 0
    t.decimal  "resource_stone_production_tax_rate",             :default => 0.0
    t.decimal  "resource_wood_production_tax_rate",              :default => 0.0
    t.decimal  "resource_fur_production_tax_rate",               :default => 0.0
    t.decimal  "resource_cash_production_tax_rate",              :default => 0.0
    t.integer  "army_size_max"
    t.integer  "garrison_size_max"
    t.datetime "tax_changed_at"
    t.integer  "trading_carts",                                  :default => 0,            :null => false
    t.integer  "settlement_unlock_p2p_trade_count",              :default => 0
    t.integer  "trading_carts_used",                             :default => 0,            :null => false
    t.integer  "settlement_queue_special_unlock_count",          :default => 0
    t.integer  "settlement_unlock_prevent_takeover_count",       :default => 0,            :null => false
    t.integer  "building_slots_total",                           :default => 1,            :null => false
  end

  create_table "settlement_slots", :force => true do |t|
    t.integer  "settlement_id"
    t.integer  "slot_num"
    t.string   "type"
    t.integer  "building_id"
    t.integer  "level",         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_bonus_offers", :force => true do |t|
    t.string   "title"
    t.integer  "price"
    t.integer  "resource_id"
    t.datetime "started_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
    t.decimal  "bonus",       :default => 0.0, :null => false
  end

  create_table "shop_credit_transactions", :force => true do |t|
    t.integer  "uid"
    t.integer  "tstamp"
    t.integer  "user_id"
    t.string   "invoice_id"
    t.string   "title_id"
    t.string   "game_id"
    t.string   "country"
    t.integer  "offer_id"
    t.string   "option_id"
    t.string   "offer_category"
    t.decimal  "gross"
    t.string   "gross_currency"
    t.string   "referrer_id"
    t.decimal  "chargeback"
    t.boolean  "tutorial"
    t.string   "tournament_id"
    t.boolean  "transaction_payed"
    t.string   "transaction_state"
    t.string   "comment"
    t.decimal  "scale_factor"
    t.integer  "money_tid"
    t.string   "hash"
    t.string   "seed"
    t.string   "partner_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_money_transactions", :force => true do |t|
    t.integer  "uid"
    t.integer  "tstamp"
    t.string   "updatetstamp"
    t.integer  "user_id"
    t.string   "invoice_id"
    t.string   "title_id"
    t.string   "method"
    t.string   "carrier"
    t.string   "country"
    t.integer  "offer_id"
    t.string   "offer_category"
    t.decimal  "gross"
    t.string   "gross_currency"
    t.decimal  "exchange_rate"
    t.decimal  "vat"
    t.decimal  "tax"
    t.decimal  "net"
    t.decimal  "fee"
    t.decimal  "ebp"
    t.string   "referrer_id"
    t.decimal  "referrer_share"
    t.decimal  "earnings"
    t.decimal  "chargeback"
    t.string   "campaign_id"
    t.boolean  "transaction_payed"
    t.string   "transaction_state"
    t.string   "comment"
    t.string   "scale_factor"
    t.string   "user_mail"
    t.string   "payment_transaction_uid"
    t.string   "payment_state"
    t.string   "payment_state_reason"
    t.string   "payer_id"
    t.string   "payer_first_name"
    t.string   "payer_last_name"
    t.string   "payer_mail"
    t.string   "payer_zip"
    t.string   "payer_city"
    t.string   "payer_street"
    t.string   "payer_country"
    t.string   "payer_state"
    t.string   "hash"
    t.string   "seed"
    t.string   "partner_user_id"
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

  create_table "shop_resource_offers", :force => true do |t|
    t.string   "title"
    t.integer  "price"
    t.integer  "amount"
    t.integer  "resource_id"
    t.datetime "started_at"
    t.datetime "ends_at"
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

  create_table "training_active_jobs", :force => true do |t|
    t.integer  "queue_id"
    t.integer  "job_id"
    t.datetime "started_total_at"
    t.float    "progress_total"
    t.integer  "quantity_active"
    t.datetime "finished_active_at"
    t.float    "progress_active"
    t.datetime "progress_active_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "progress_total_updated_at"
    t.datetime "finished_total_at"
    t.datetime "started_active_at"
  end

  create_table "training_jobs", :force => true do |t|
    t.integer  "queue_id"
    t.integer  "unit_id"
    t.integer  "position"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity_finished"
    t.boolean  "hurried",           :default => false, :null => false
  end

  create_table "training_queues", :force => true do |t|
    t.integer  "settlement_id"
    t.integer  "type_id"
    t.integer  "threads"
    t.integer  "jobs_count",        :default => 0,   :null => false
    t.decimal  "speedup_buildings", :default => 0.0, :null => false
    t.decimal  "speedup_sciences",  :default => 0.0, :null => false
    t.decimal  "speedup_alliance",  :default => 0.0, :null => false
    t.decimal  "speedup_effects",   :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "speed",             :default => 1.0, :null => false
  end

  create_table "tutorial_quests", :force => true do |t|
    t.integer  "state_id"
    t.integer  "quest_id"
    t.datetime "displayed_at"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",       :default => 0
    t.datetime "closed_at"
  end

  create_table "tutorial_states", :force => true do |t|
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
