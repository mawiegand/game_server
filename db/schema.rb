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

ActiveRecord::Schema.define(:version => 20130701132213) do

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
    t.boolean  "send_hurried"
    t.boolean  "return_hurried"
  end

  create_table "assignment_special_assignment_frequencies", :force => true do |t|
    t.integer  "character_id"
    t.integer  "type_id"
    t.integer  "num_failed"
    t.datetime "last_ended_at"
    t.integer  "execution_count", :default => 0, :null => false
    t.integer  "halved_count",    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignment_special_assignments", :force => true do |t|
    t.integer  "character_id"
    t.integer  "type_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "halved_at"
    t.integer  "execution_count",              :default => 0, :null => false
    t.datetime "displayed_until"
    t.datetime "seen_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experience_reward"
    t.integer  "resource_stone_cost"
    t.integer  "resource_stone_reward"
    t.integer  "resource_wood_cost"
    t.integer  "resource_wood_reward"
    t.integer  "resource_fur_cost"
    t.integer  "resource_fur_reward"
    t.integer  "resource_cash_cost"
    t.integer  "resource_cash_reward"
    t.integer  "unit_clubbers_deposit"
    t.integer  "unit_clubbers_reward"
    t.integer  "unit_clubbers_2_deposit"
    t.integer  "unit_clubbers_2_reward"
    t.integer  "unit_clubbers_3_deposit"
    t.integer  "unit_clubbers_3_reward"
    t.integer  "unit_tree_huggers_deposit"
    t.integer  "unit_tree_huggers_reward"
    t.integer  "unit_thrower_deposit"
    t.integer  "unit_thrower_reward"
    t.integer  "unit_thrower_2_deposit"
    t.integer  "unit_thrower_2_reward"
    t.integer  "unit_thrower_3_deposit"
    t.integer  "unit_thrower_3_reward"
    t.integer  "unit_thrower_4_deposit"
    t.integer  "unit_thrower_4_reward"
    t.integer  "unit_light_cavalry_deposit"
    t.integer  "unit_light_cavalry_reward"
    t.integer  "unit_light_cavalry_2_deposit"
    t.integer  "unit_light_cavalry_2_reward"
    t.integer  "unit_light_cavalry_3_deposit"
    t.integer  "unit_light_cavalry_3_reward"
    t.integer  "unit_light_cavalry_4_deposit"
    t.integer  "unit_light_cavalry_4_reward"
    t.integer  "unit_neanderthal_deposit"
    t.integer  "unit_neanderthal_reward"
    t.integer  "unit_little_chief_deposit"
    t.integer  "unit_little_chief_reward"
    t.integer  "unit_warrior_deposit"
    t.integer  "unit_warrior_reward"
  end

  create_table "assignment_standard_assignments", :force => true do |t|
    t.integer  "character_id"
    t.integer  "type_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "halved_at"
    t.integer  "execution_count", :default => 0, :null => false
    t.integer  "halved_count",    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backend_browser_stats", :force => true do |t|
    t.string   "identifier"
    t.boolean  "success"
    t.string   "user_agent"
    t.text     "modernizr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backend_partner_sites", :force => true do |t|
    t.integer  "backend_user_id"
    t.string   "referer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "r"
    t.string   "description"
    t.integer  "sign_ups_count"
    t.decimal  "playtime",               :default => 0.0, :null => false
    t.decimal  "gross",                  :default => 0.0, :null => false
    t.decimal  "revenue",                :default => 0.0, :null => false
    t.integer  "total_churned",          :default => 0,   :null => false
    t.integer  "total_logged_in_once",   :default => 0,   :null => false
    t.integer  "total_ten_minutes",      :default => 0,   :null => false
    t.integer  "total_second_day",       :default => 0,   :null => false
    t.integer  "total_active",           :default => 0,   :null => false
    t.integer  "total_long_term_active", :default => 0,   :null => false
    t.integer  "total_paying",           :default => 0,   :null => false
  end

  create_table "backend_sign_in_log_entries", :force => true do |t|
    t.integer  "character_id"
    t.text     "user_agent"
    t.string   "referer"
    t.text     "referer_url"
    t.string   "remote_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sign_up",            :default => false, :null => false
    t.text     "direct_referer_url"
    t.text     "request_url"
    t.text     "r"
    t.text     "k"
    t.text     "p"
    t.text     "n"
    t.integer  "partner_site_id"
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
    t.decimal  "mgross",                             :default => 0.0, :null => false
    t.decimal  "wgross",                             :default => 0.0, :null => false
    t.decimal  "dgross",                             :default => 0.0, :null => false
    t.decimal  "day_gross",                          :default => 0.0, :null => false
    t.decimal  "month_gross",                        :default => 0.0, :null => false
    t.integer  "day_finished_quests",                :default => 0,   :null => false
    t.integer  "month_finished_quests",              :default => 0,   :null => false
    t.integer  "month_num_ten_minutes",              :default => 0,   :null => false
    t.integer  "day_num_ten_minutes",                :default => 0,   :null => false
    t.integer  "dtimenew",                           :default => 0,   :null => false
    t.integer  "wtimenew",                           :default => 0,   :null => false
    t.integer  "mtimenew",                           :default => 0,   :null => false
    t.integer  "month_inactive",                     :default => 0,   :null => false
    t.integer  "day_inactive",                       :default => 0,   :null => false
    t.integer  "total_logged_in_once",               :default => 0,   :null => false
    t.integer  "total_ten_minutes",                  :default => 0,   :null => false
    t.integer  "total_second_day",                   :default => 0,   :null => false
    t.integer  "total_active",                       :default => 0,   :null => false
    t.integer  "total_long_term_active",             :default => 0,   :null => false
  end

  create_table "backend_trade_log_entries", :force => true do |t|
    t.integer  "sender_id",                              :null => false
    t.string   "sender_name",                            :null => false
    t.integer  "sender_alliance_id"
    t.string   "sender_alliance_name"
    t.integer  "recipient_id",                           :null => false
    t.string   "recipient_name",                         :null => false
    t.integer  "recipient_alliance_id"
    t.string   "recipient_alliance_name"
    t.datetime "target_reached_at"
    t.integer  "num_carts",               :default => 0, :null => false
    t.integer  "event_id"
    t.string   "sender_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resource_stone_amount",   :default => 0, :null => false
    t.integer  "resource_wood_amount",    :default => 0, :null => false
    t.integer  "resource_fur_amount",     :default => 0, :null => false
    t.integer  "resource_cash_amount",    :default => 0, :null => false
  end

  create_table "backend_tutorial_stats", :force => true do |t|
    t.integer  "cohort_size",                       :default => 0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quest_0_num_finished_day_1",        :default => 0
    t.integer  "quest_0_num_started_day_1",         :default => 0
    t.decimal  "quest_0_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_0_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_0_num_finished",              :default => 0
    t.integer  "quest_0_num_started",               :default => 0
    t.decimal  "quest_0_playtime_finished",         :default => 0.0
    t.decimal  "quest_0_playtime_started",          :default => 0.0
    t.integer  "quest_1_num_finished_day_1",        :default => 0
    t.integer  "quest_1_num_started_day_1",         :default => 0
    t.decimal  "quest_1_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_1_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_1_num_finished",              :default => 0
    t.integer  "quest_1_num_started",               :default => 0
    t.decimal  "quest_1_playtime_finished",         :default => 0.0
    t.decimal  "quest_1_playtime_started",          :default => 0.0
    t.integer  "quest_2_num_finished_day_1",        :default => 0
    t.integer  "quest_2_num_started_day_1",         :default => 0
    t.decimal  "quest_2_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_2_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_2_num_finished",              :default => 0
    t.integer  "quest_2_num_started",               :default => 0
    t.decimal  "quest_2_playtime_finished",         :default => 0.0
    t.decimal  "quest_2_playtime_started",          :default => 0.0
    t.integer  "quest_3_num_finished_day_1",        :default => 0
    t.integer  "quest_3_num_started_day_1",         :default => 0
    t.decimal  "quest_3_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_3_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_3_num_finished",              :default => 0
    t.integer  "quest_3_num_started",               :default => 0
    t.decimal  "quest_3_playtime_finished",         :default => 0.0
    t.decimal  "quest_3_playtime_started",          :default => 0.0
    t.integer  "quest_4_num_finished_day_1",        :default => 0
    t.integer  "quest_4_num_started_day_1",         :default => 0
    t.decimal  "quest_4_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_4_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_4_num_finished",              :default => 0
    t.integer  "quest_4_num_started",               :default => 0
    t.decimal  "quest_4_playtime_finished",         :default => 0.0
    t.decimal  "quest_4_playtime_started",          :default => 0.0
    t.integer  "quest_5_num_finished_day_1",        :default => 0
    t.integer  "quest_5_num_started_day_1",         :default => 0
    t.decimal  "quest_5_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_5_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_5_num_finished",              :default => 0
    t.integer  "quest_5_num_started",               :default => 0
    t.decimal  "quest_5_playtime_finished",         :default => 0.0
    t.decimal  "quest_5_playtime_started",          :default => 0.0
    t.integer  "quest_6_num_finished_day_1",        :default => 0
    t.integer  "quest_6_num_started_day_1",         :default => 0
    t.decimal  "quest_6_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_6_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_6_num_finished",              :default => 0
    t.integer  "quest_6_num_started",               :default => 0
    t.decimal  "quest_6_playtime_finished",         :default => 0.0
    t.decimal  "quest_6_playtime_started",          :default => 0.0
    t.integer  "quest_7_num_finished_day_1",        :default => 0
    t.integer  "quest_7_num_started_day_1",         :default => 0
    t.decimal  "quest_7_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_7_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_7_num_finished",              :default => 0
    t.integer  "quest_7_num_started",               :default => 0
    t.decimal  "quest_7_playtime_finished",         :default => 0.0
    t.decimal  "quest_7_playtime_started",          :default => 0.0
    t.integer  "quest_8_num_finished_day_1",        :default => 0
    t.integer  "quest_8_num_started_day_1",         :default => 0
    t.decimal  "quest_8_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_8_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_8_num_finished",              :default => 0
    t.integer  "quest_8_num_started",               :default => 0
    t.decimal  "quest_8_playtime_finished",         :default => 0.0
    t.decimal  "quest_8_playtime_started",          :default => 0.0
    t.integer  "quest_9_num_finished_day_1",        :default => 0
    t.integer  "quest_9_num_started_day_1",         :default => 0
    t.decimal  "quest_9_playtime_finished_day_1",   :default => 0.0
    t.decimal  "quest_9_playtime_started_day_1",    :default => 0.0
    t.integer  "quest_9_num_finished",              :default => 0
    t.integer  "quest_9_num_started",               :default => 0
    t.decimal  "quest_9_playtime_finished",         :default => 0.0
    t.decimal  "quest_9_playtime_started",          :default => 0.0
    t.integer  "quest_10_num_finished_day_1",       :default => 0
    t.integer  "quest_10_num_started_day_1",        :default => 0
    t.decimal  "quest_10_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_10_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_10_num_finished",             :default => 0
    t.integer  "quest_10_num_started",              :default => 0
    t.decimal  "quest_10_playtime_finished",        :default => 0.0
    t.decimal  "quest_10_playtime_started",         :default => 0.0
    t.integer  "quest_11_num_finished_day_1",       :default => 0
    t.integer  "quest_11_num_started_day_1",        :default => 0
    t.decimal  "quest_11_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_11_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_11_num_finished",             :default => 0
    t.integer  "quest_11_num_started",              :default => 0
    t.decimal  "quest_11_playtime_finished",        :default => 0.0
    t.decimal  "quest_11_playtime_started",         :default => 0.0
    t.integer  "quest_12_num_finished_day_1",       :default => 0
    t.integer  "quest_12_num_started_day_1",        :default => 0
    t.decimal  "quest_12_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_12_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_12_num_finished",             :default => 0
    t.integer  "quest_12_num_started",              :default => 0
    t.decimal  "quest_12_playtime_finished",        :default => 0.0
    t.decimal  "quest_12_playtime_started",         :default => 0.0
    t.integer  "quest_13_num_finished_day_1",       :default => 0
    t.integer  "quest_13_num_started_day_1",        :default => 0
    t.decimal  "quest_13_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_13_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_13_num_finished",             :default => 0
    t.integer  "quest_13_num_started",              :default => 0
    t.decimal  "quest_13_playtime_finished",        :default => 0.0
    t.decimal  "quest_13_playtime_started",         :default => 0.0
    t.integer  "quest_14_num_finished_day_1",       :default => 0
    t.integer  "quest_14_num_started_day_1",        :default => 0
    t.decimal  "quest_14_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_14_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_14_num_finished",             :default => 0
    t.integer  "quest_14_num_started",              :default => 0
    t.decimal  "quest_14_playtime_finished",        :default => 0.0
    t.decimal  "quest_14_playtime_started",         :default => 0.0
    t.integer  "quest_15_num_finished_day_1",       :default => 0
    t.integer  "quest_15_num_started_day_1",        :default => 0
    t.decimal  "quest_15_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_15_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_15_num_finished",             :default => 0
    t.integer  "quest_15_num_started",              :default => 0
    t.decimal  "quest_15_playtime_finished",        :default => 0.0
    t.decimal  "quest_15_playtime_started",         :default => 0.0
    t.integer  "quest_16_num_finished_day_1",       :default => 0
    t.integer  "quest_16_num_started_day_1",        :default => 0
    t.decimal  "quest_16_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_16_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_16_num_finished",             :default => 0
    t.integer  "quest_16_num_started",              :default => 0
    t.decimal  "quest_16_playtime_finished",        :default => 0.0
    t.decimal  "quest_16_playtime_started",         :default => 0.0
    t.integer  "quest_17_num_finished_day_1",       :default => 0
    t.integer  "quest_17_num_started_day_1",        :default => 0
    t.decimal  "quest_17_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_17_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_17_num_finished",             :default => 0
    t.integer  "quest_17_num_started",              :default => 0
    t.decimal  "quest_17_playtime_finished",        :default => 0.0
    t.decimal  "quest_17_playtime_started",         :default => 0.0
    t.integer  "quest_18_num_finished_day_1",       :default => 0
    t.integer  "quest_18_num_started_day_1",        :default => 0
    t.decimal  "quest_18_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_18_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_18_num_finished",             :default => 0
    t.integer  "quest_18_num_started",              :default => 0
    t.decimal  "quest_18_playtime_finished",        :default => 0.0
    t.decimal  "quest_18_playtime_started",         :default => 0.0
    t.integer  "quest_19_num_finished_day_1",       :default => 0
    t.integer  "quest_19_num_started_day_1",        :default => 0
    t.decimal  "quest_19_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_19_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_19_num_finished",             :default => 0
    t.integer  "quest_19_num_started",              :default => 0
    t.decimal  "quest_19_playtime_finished",        :default => 0.0
    t.decimal  "quest_19_playtime_started",         :default => 0.0
    t.integer  "quest_20_num_finished_day_1",       :default => 0
    t.integer  "quest_20_num_started_day_1",        :default => 0
    t.decimal  "quest_20_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_20_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_20_num_finished",             :default => 0
    t.integer  "quest_20_num_started",              :default => 0
    t.decimal  "quest_20_playtime_finished",        :default => 0.0
    t.decimal  "quest_20_playtime_started",         :default => 0.0
    t.integer  "quest_21_num_finished_day_1",       :default => 0
    t.integer  "quest_21_num_started_day_1",        :default => 0
    t.decimal  "quest_21_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_21_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_21_num_finished",             :default => 0
    t.integer  "quest_21_num_started",              :default => 0
    t.decimal  "quest_21_playtime_finished",        :default => 0.0
    t.decimal  "quest_21_playtime_started",         :default => 0.0
    t.integer  "quest_22_num_finished_day_1",       :default => 0
    t.integer  "quest_22_num_started_day_1",        :default => 0
    t.decimal  "quest_22_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_22_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_22_num_finished",             :default => 0
    t.integer  "quest_22_num_started",              :default => 0
    t.decimal  "quest_22_playtime_finished",        :default => 0.0
    t.decimal  "quest_22_playtime_started",         :default => 0.0
    t.integer  "quest_23_num_finished_day_1",       :default => 0
    t.integer  "quest_23_num_started_day_1",        :default => 0
    t.decimal  "quest_23_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_23_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_23_num_finished",             :default => 0
    t.integer  "quest_23_num_started",              :default => 0
    t.decimal  "quest_23_playtime_finished",        :default => 0.0
    t.decimal  "quest_23_playtime_started",         :default => 0.0
    t.integer  "quest_24_num_finished_day_1",       :default => 0
    t.integer  "quest_24_num_started_day_1",        :default => 0
    t.decimal  "quest_24_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_24_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_24_num_finished",             :default => 0
    t.integer  "quest_24_num_started",              :default => 0
    t.decimal  "quest_24_playtime_finished",        :default => 0.0
    t.decimal  "quest_24_playtime_started",         :default => 0.0
    t.integer  "quest_25_num_finished_day_1",       :default => 0
    t.integer  "quest_25_num_started_day_1",        :default => 0
    t.decimal  "quest_25_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_25_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_25_num_finished",             :default => 0
    t.integer  "quest_25_num_started",              :default => 0
    t.decimal  "quest_25_playtime_finished",        :default => 0.0
    t.decimal  "quest_25_playtime_started",         :default => 0.0
    t.integer  "quest_26_num_finished_day_1",       :default => 0
    t.integer  "quest_26_num_started_day_1",        :default => 0
    t.decimal  "quest_26_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_26_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_26_num_finished",             :default => 0
    t.integer  "quest_26_num_started",              :default => 0
    t.decimal  "quest_26_playtime_finished",        :default => 0.0
    t.decimal  "quest_26_playtime_started",         :default => 0.0
    t.integer  "quest_27_num_finished_day_1",       :default => 0
    t.integer  "quest_27_num_started_day_1",        :default => 0
    t.decimal  "quest_27_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_27_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_27_num_finished",             :default => 0
    t.integer  "quest_27_num_started",              :default => 0
    t.decimal  "quest_27_playtime_finished",        :default => 0.0
    t.decimal  "quest_27_playtime_started",         :default => 0.0
    t.integer  "quest_28_num_finished_day_1",       :default => 0
    t.integer  "quest_28_num_started_day_1",        :default => 0
    t.decimal  "quest_28_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_28_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_28_num_finished",             :default => 0
    t.integer  "quest_28_num_started",              :default => 0
    t.decimal  "quest_28_playtime_finished",        :default => 0.0
    t.decimal  "quest_28_playtime_started",         :default => 0.0
    t.integer  "quest_29_num_finished_day_1",       :default => 0
    t.integer  "quest_29_num_started_day_1",        :default => 0
    t.decimal  "quest_29_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_29_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_29_num_finished",             :default => 0
    t.integer  "quest_29_num_started",              :default => 0
    t.decimal  "quest_29_playtime_finished",        :default => 0.0
    t.decimal  "quest_29_playtime_started",         :default => 0.0
    t.integer  "quest_30_num_finished_day_1",       :default => 0
    t.integer  "quest_30_num_started_day_1",        :default => 0
    t.decimal  "quest_30_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_30_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_30_num_finished",             :default => 0
    t.integer  "quest_30_num_started",              :default => 0
    t.decimal  "quest_30_playtime_finished",        :default => 0.0
    t.decimal  "quest_30_playtime_started",         :default => 0.0
    t.integer  "quest_31_num_finished_day_1",       :default => 0
    t.integer  "quest_31_num_started_day_1",        :default => 0
    t.decimal  "quest_31_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_31_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_31_num_finished",             :default => 0
    t.integer  "quest_31_num_started",              :default => 0
    t.decimal  "quest_31_playtime_finished",        :default => 0.0
    t.decimal  "quest_31_playtime_started",         :default => 0.0
    t.integer  "quest_32_num_finished_day_1",       :default => 0
    t.integer  "quest_32_num_started_day_1",        :default => 0
    t.decimal  "quest_32_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_32_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_32_num_finished",             :default => 0
    t.integer  "quest_32_num_started",              :default => 0
    t.decimal  "quest_32_playtime_finished",        :default => 0.0
    t.decimal  "quest_32_playtime_started",         :default => 0.0
    t.integer  "quest_33_num_finished_day_1",       :default => 0
    t.integer  "quest_33_num_started_day_1",        :default => 0
    t.decimal  "quest_33_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_33_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_33_num_finished",             :default => 0
    t.integer  "quest_33_num_started",              :default => 0
    t.decimal  "quest_33_playtime_finished",        :default => 0.0
    t.decimal  "quest_33_playtime_started",         :default => 0.0
    t.integer  "quest_34_num_finished_day_1",       :default => 0
    t.integer  "quest_34_num_started_day_1",        :default => 0
    t.decimal  "quest_34_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_34_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_34_num_finished",             :default => 0
    t.integer  "quest_34_num_started",              :default => 0
    t.decimal  "quest_34_playtime_finished",        :default => 0.0
    t.decimal  "quest_34_playtime_started",         :default => 0.0
    t.integer  "quest_35_num_finished_day_1",       :default => 0
    t.integer  "quest_35_num_started_day_1",        :default => 0
    t.decimal  "quest_35_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_35_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_35_num_finished",             :default => 0
    t.integer  "quest_35_num_started",              :default => 0
    t.decimal  "quest_35_playtime_finished",        :default => 0.0
    t.decimal  "quest_35_playtime_started",         :default => 0.0
    t.integer  "quest_36_num_finished_day_1",       :default => 0
    t.integer  "quest_36_num_started_day_1",        :default => 0
    t.decimal  "quest_36_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_36_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_36_num_finished",             :default => 0
    t.integer  "quest_36_num_started",              :default => 0
    t.decimal  "quest_36_playtime_finished",        :default => 0.0
    t.decimal  "quest_36_playtime_started",         :default => 0.0
    t.integer  "quest_37_num_finished_day_1",       :default => 0
    t.integer  "quest_37_num_started_day_1",        :default => 0
    t.decimal  "quest_37_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_37_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_37_num_finished",             :default => 0
    t.integer  "quest_37_num_started",              :default => 0
    t.decimal  "quest_37_playtime_finished",        :default => 0.0
    t.decimal  "quest_37_playtime_started",         :default => 0.0
    t.integer  "quest_38_num_finished_day_1",       :default => 0
    t.integer  "quest_38_num_started_day_1",        :default => 0
    t.decimal  "quest_38_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_38_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_38_num_finished",             :default => 0
    t.integer  "quest_38_num_started",              :default => 0
    t.decimal  "quest_38_playtime_finished",        :default => 0.0
    t.decimal  "quest_38_playtime_started",         :default => 0.0
    t.integer  "quest_39_num_finished_day_1",       :default => 0
    t.integer  "quest_39_num_started_day_1",        :default => 0
    t.decimal  "quest_39_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_39_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_39_num_finished",             :default => 0
    t.integer  "quest_39_num_started",              :default => 0
    t.decimal  "quest_39_playtime_finished",        :default => 0.0
    t.decimal  "quest_39_playtime_started",         :default => 0.0
    t.integer  "quest_40_num_finished_day_1",       :default => 0
    t.integer  "quest_40_num_started_day_1",        :default => 0
    t.decimal  "quest_40_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_40_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_40_num_finished",             :default => 0
    t.integer  "quest_40_num_started",              :default => 0
    t.decimal  "quest_40_playtime_finished",        :default => 0.0
    t.decimal  "quest_40_playtime_started",         :default => 0.0
    t.integer  "quest_41_num_finished_day_1",       :default => 0
    t.integer  "quest_41_num_started_day_1",        :default => 0
    t.decimal  "quest_41_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_41_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_41_num_finished",             :default => 0
    t.integer  "quest_41_num_started",              :default => 0
    t.decimal  "quest_41_playtime_finished",        :default => 0.0
    t.decimal  "quest_41_playtime_started",         :default => 0.0
    t.integer  "quest_42_num_finished_day_1",       :default => 0
    t.integer  "quest_42_num_started_day_1",        :default => 0
    t.decimal  "quest_42_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_42_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_42_num_finished",             :default => 0
    t.integer  "quest_42_num_started",              :default => 0
    t.decimal  "quest_42_playtime_finished",        :default => 0.0
    t.decimal  "quest_42_playtime_started",         :default => 0.0
    t.integer  "quest_43_num_finished_day_1",       :default => 0
    t.integer  "quest_43_num_started_day_1",        :default => 0
    t.decimal  "quest_43_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_43_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_43_num_finished",             :default => 0
    t.integer  "quest_43_num_started",              :default => 0
    t.decimal  "quest_43_playtime_finished",        :default => 0.0
    t.decimal  "quest_43_playtime_started",         :default => 0.0
    t.integer  "quest_44_num_finished_day_1",       :default => 0
    t.integer  "quest_44_num_started_day_1",        :default => 0
    t.decimal  "quest_44_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_44_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_44_num_finished",             :default => 0
    t.integer  "quest_44_num_started",              :default => 0
    t.decimal  "quest_44_playtime_finished",        :default => 0.0
    t.decimal  "quest_44_playtime_started",         :default => 0.0
    t.integer  "quest_45_num_finished_day_1",       :default => 0
    t.integer  "quest_45_num_started_day_1",        :default => 0
    t.decimal  "quest_45_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_45_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_45_num_finished",             :default => 0
    t.integer  "quest_45_num_started",              :default => 0
    t.decimal  "quest_45_playtime_finished",        :default => 0.0
    t.decimal  "quest_45_playtime_started",         :default => 0.0
    t.integer  "quest_46_num_finished_day_1",       :default => 0
    t.integer  "quest_46_num_started_day_1",        :default => 0
    t.decimal  "quest_46_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_46_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_46_num_finished",             :default => 0
    t.integer  "quest_46_num_started",              :default => 0
    t.decimal  "quest_46_playtime_finished",        :default => 0.0
    t.decimal  "quest_46_playtime_started",         :default => 0.0
    t.integer  "quest_47_num_finished_day_1",       :default => 0
    t.integer  "quest_47_num_started_day_1",        :default => 0
    t.decimal  "quest_47_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_47_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_47_num_finished",             :default => 0
    t.integer  "quest_47_num_started",              :default => 0
    t.decimal  "quest_47_playtime_finished",        :default => 0.0
    t.decimal  "quest_47_playtime_started",         :default => 0.0
    t.integer  "quest_48_num_finished_day_1",       :default => 0
    t.integer  "quest_48_num_started_day_1",        :default => 0
    t.decimal  "quest_48_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_48_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_48_num_finished",             :default => 0
    t.integer  "quest_48_num_started",              :default => 0
    t.decimal  "quest_48_playtime_finished",        :default => 0.0
    t.decimal  "quest_48_playtime_started",         :default => 0.0
    t.integer  "quest_49_num_finished_day_1",       :default => 0
    t.integer  "quest_49_num_started_day_1",        :default => 0
    t.decimal  "quest_49_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_49_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_49_num_finished",             :default => 0
    t.integer  "quest_49_num_started",              :default => 0
    t.decimal  "quest_49_playtime_finished",        :default => 0.0
    t.decimal  "quest_49_playtime_started",         :default => 0.0
    t.integer  "quest_50_num_finished_day_1",       :default => 0
    t.integer  "quest_50_num_started_day_1",        :default => 0
    t.decimal  "quest_50_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_50_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_50_num_finished",             :default => 0
    t.integer  "quest_50_num_started",              :default => 0
    t.decimal  "quest_50_playtime_finished",        :default => 0.0
    t.decimal  "quest_50_playtime_started",         :default => 0.0
    t.integer  "quest_51_num_finished_day_1",       :default => 0
    t.integer  "quest_51_num_started_day_1",        :default => 0
    t.decimal  "quest_51_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_51_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_51_num_finished",             :default => 0
    t.integer  "quest_51_num_started",              :default => 0
    t.decimal  "quest_51_playtime_finished",        :default => 0.0
    t.decimal  "quest_51_playtime_started",         :default => 0.0
    t.integer  "quest_52_num_finished_day_1",       :default => 0
    t.integer  "quest_52_num_started_day_1",        :default => 0
    t.decimal  "quest_52_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_52_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_52_num_finished",             :default => 0
    t.integer  "quest_52_num_started",              :default => 0
    t.decimal  "quest_52_playtime_finished",        :default => 0.0
    t.decimal  "quest_52_playtime_started",         :default => 0.0
    t.integer  "quest_53_num_finished_day_1",       :default => 0
    t.integer  "quest_53_num_started_day_1",        :default => 0
    t.decimal  "quest_53_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_53_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_53_num_finished",             :default => 0
    t.integer  "quest_53_num_started",              :default => 0
    t.decimal  "quest_53_playtime_finished",        :default => 0.0
    t.decimal  "quest_53_playtime_started",         :default => 0.0
    t.integer  "quest_54_num_finished_day_1",       :default => 0
    t.integer  "quest_54_num_started_day_1",        :default => 0
    t.decimal  "quest_54_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_54_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_54_num_finished",             :default => 0
    t.integer  "quest_54_num_started",              :default => 0
    t.decimal  "quest_54_playtime_finished",        :default => 0.0
    t.decimal  "quest_54_playtime_started",         :default => 0.0
    t.integer  "quest_55_num_finished_day_1",       :default => 0
    t.integer  "quest_55_num_started_day_1",        :default => 0
    t.decimal  "quest_55_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_55_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_55_num_finished",             :default => 0
    t.integer  "quest_55_num_started",              :default => 0
    t.decimal  "quest_55_playtime_finished",        :default => 0.0
    t.decimal  "quest_55_playtime_started",         :default => 0.0
    t.integer  "quest_56_num_finished_day_1",       :default => 0
    t.integer  "quest_56_num_started_day_1",        :default => 0
    t.decimal  "quest_56_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_56_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_56_num_finished",             :default => 0
    t.integer  "quest_56_num_started",              :default => 0
    t.decimal  "quest_56_playtime_finished",        :default => 0.0
    t.decimal  "quest_56_playtime_started",         :default => 0.0
    t.integer  "quest_57_num_finished_day_1",       :default => 0
    t.integer  "quest_57_num_started_day_1",        :default => 0
    t.decimal  "quest_57_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_57_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_57_num_finished",             :default => 0
    t.integer  "quest_57_num_started",              :default => 0
    t.decimal  "quest_57_playtime_finished",        :default => 0.0
    t.decimal  "quest_57_playtime_started",         :default => 0.0
    t.integer  "quest_58_num_finished_day_1",       :default => 0
    t.integer  "quest_58_num_started_day_1",        :default => 0
    t.decimal  "quest_58_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_58_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_58_num_finished",             :default => 0
    t.integer  "quest_58_num_started",              :default => 0
    t.decimal  "quest_58_playtime_finished",        :default => 0.0
    t.decimal  "quest_58_playtime_started",         :default => 0.0
    t.integer  "week_cohort_size",                  :default => 0
    t.decimal  "quest_0_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_1_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_2_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_3_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_4_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_5_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_6_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_7_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_8_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_9_retention_rate_week_1",     :default => 0.0
    t.decimal  "quest_10_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_11_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_12_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_13_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_14_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_15_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_16_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_17_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_18_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_19_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_20_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_21_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_22_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_23_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_24_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_25_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_26_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_27_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_28_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_29_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_30_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_31_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_32_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_33_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_34_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_35_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_36_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_37_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_38_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_39_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_40_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_41_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_42_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_43_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_44_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_45_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_46_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_47_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_48_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_49_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_50_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_51_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_52_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_53_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_54_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_55_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_56_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_57_retention_rate_week_1",    :default => 0.0
    t.decimal  "quest_58_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_59_num_finished_day_1",       :default => 0
    t.integer  "quest_59_num_started_day_1",        :default => 0
    t.decimal  "quest_59_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_59_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_59_num_finished",             :default => 0
    t.integer  "quest_59_num_started",              :default => 0
    t.decimal  "quest_59_playtime_finished",        :default => 0.0
    t.decimal  "quest_59_playtime_started",         :default => 0.0
    t.decimal  "quest_59_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_60_num_finished_day_1",       :default => 0
    t.integer  "quest_60_num_started_day_1",        :default => 0
    t.decimal  "quest_60_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_60_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_60_num_finished",             :default => 0
    t.integer  "quest_60_num_started",              :default => 0
    t.decimal  "quest_60_playtime_finished",        :default => 0.0
    t.decimal  "quest_60_playtime_started",         :default => 0.0
    t.decimal  "quest_60_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_61_num_finished_day_1",       :default => 0
    t.integer  "quest_61_num_started_day_1",        :default => 0
    t.decimal  "quest_61_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_61_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_61_num_finished",             :default => 0
    t.integer  "quest_61_num_started",              :default => 0
    t.decimal  "quest_61_playtime_finished",        :default => 0.0
    t.decimal  "quest_61_playtime_started",         :default => 0.0
    t.decimal  "quest_61_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_62_num_finished_day_1",       :default => 0
    t.integer  "quest_62_num_started_day_1",        :default => 0
    t.decimal  "quest_62_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_62_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_62_num_finished",             :default => 0
    t.integer  "quest_62_num_started",              :default => 0
    t.decimal  "quest_62_playtime_finished",        :default => 0.0
    t.decimal  "quest_62_playtime_started",         :default => 0.0
    t.decimal  "quest_62_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_63_num_finished_day_1",       :default => 0
    t.integer  "quest_63_num_started_day_1",        :default => 0
    t.decimal  "quest_63_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_63_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_63_num_finished",             :default => 0
    t.integer  "quest_63_num_started",              :default => 0
    t.decimal  "quest_63_playtime_finished",        :default => 0.0
    t.decimal  "quest_63_playtime_started",         :default => 0.0
    t.decimal  "quest_63_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_64_num_finished_day_1",       :default => 0
    t.integer  "quest_64_num_started_day_1",        :default => 0
    t.decimal  "quest_64_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_64_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_64_num_finished",             :default => 0
    t.integer  "quest_64_num_started",              :default => 0
    t.decimal  "quest_64_playtime_finished",        :default => 0.0
    t.decimal  "quest_64_playtime_started",         :default => 0.0
    t.decimal  "quest_64_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_65_num_finished_day_1",       :default => 0
    t.integer  "quest_65_num_started_day_1",        :default => 0
    t.decimal  "quest_65_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_65_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_65_num_finished",             :default => 0
    t.integer  "quest_65_num_started",              :default => 0
    t.decimal  "quest_65_playtime_finished",        :default => 0.0
    t.decimal  "quest_65_playtime_started",         :default => 0.0
    t.decimal  "quest_65_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_66_num_finished_day_1",       :default => 0
    t.integer  "quest_66_num_started_day_1",        :default => 0
    t.decimal  "quest_66_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_66_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_66_num_finished",             :default => 0
    t.integer  "quest_66_num_started",              :default => 0
    t.decimal  "quest_66_playtime_finished",        :default => 0.0
    t.decimal  "quest_66_playtime_started",         :default => 0.0
    t.decimal  "quest_66_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_67_num_finished_day_1",       :default => 0
    t.integer  "quest_67_num_started_day_1",        :default => 0
    t.decimal  "quest_67_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_67_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_67_num_finished",             :default => 0
    t.integer  "quest_67_num_started",              :default => 0
    t.decimal  "quest_67_playtime_finished",        :default => 0.0
    t.decimal  "quest_67_playtime_started",         :default => 0.0
    t.decimal  "quest_67_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_68_num_finished_day_1",       :default => 0
    t.integer  "quest_68_num_started_day_1",        :default => 0
    t.decimal  "quest_68_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_68_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_68_num_finished",             :default => 0
    t.integer  "quest_68_num_started",              :default => 0
    t.decimal  "quest_68_playtime_finished",        :default => 0.0
    t.decimal  "quest_68_playtime_started",         :default => 0.0
    t.decimal  "quest_68_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_69_num_finished_day_1",       :default => 0
    t.integer  "quest_69_num_started_day_1",        :default => 0
    t.decimal  "quest_69_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_69_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_69_num_finished",             :default => 0
    t.integer  "quest_69_num_started",              :default => 0
    t.decimal  "quest_69_playtime_finished",        :default => 0.0
    t.decimal  "quest_69_playtime_started",         :default => 0.0
    t.decimal  "quest_69_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_70_num_finished_day_1",       :default => 0
    t.integer  "quest_70_num_started_day_1",        :default => 0
    t.decimal  "quest_70_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_70_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_70_num_finished",             :default => 0
    t.integer  "quest_70_num_started",              :default => 0
    t.decimal  "quest_70_playtime_finished",        :default => 0.0
    t.decimal  "quest_70_playtime_started",         :default => 0.0
    t.decimal  "quest_70_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_71_num_finished_day_1",       :default => 0
    t.integer  "quest_71_num_started_day_1",        :default => 0
    t.decimal  "quest_71_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_71_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_71_num_finished",             :default => 0
    t.integer  "quest_71_num_started",              :default => 0
    t.decimal  "quest_71_playtime_finished",        :default => 0.0
    t.decimal  "quest_71_playtime_started",         :default => 0.0
    t.decimal  "quest_71_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_72_num_finished_day_1",       :default => 0
    t.integer  "quest_72_num_started_day_1",        :default => 0
    t.decimal  "quest_72_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_72_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_72_num_finished",             :default => 0
    t.integer  "quest_72_num_started",              :default => 0
    t.decimal  "quest_72_playtime_finished",        :default => 0.0
    t.decimal  "quest_72_playtime_started",         :default => 0.0
    t.decimal  "quest_72_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_73_num_finished_day_1",       :default => 0
    t.integer  "quest_73_num_started_day_1",        :default => 0
    t.decimal  "quest_73_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_73_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_73_num_finished",             :default => 0
    t.integer  "quest_73_num_started",              :default => 0
    t.decimal  "quest_73_playtime_finished",        :default => 0.0
    t.decimal  "quest_73_playtime_started",         :default => 0.0
    t.decimal  "quest_73_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_74_num_finished_day_1",       :default => 0
    t.integer  "quest_74_num_started_day_1",        :default => 0
    t.decimal  "quest_74_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_74_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_74_num_finished",             :default => 0
    t.integer  "quest_74_num_started",              :default => 0
    t.decimal  "quest_74_playtime_finished",        :default => 0.0
    t.decimal  "quest_74_playtime_started",         :default => 0.0
    t.decimal  "quest_74_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_75_num_finished_day_1",       :default => 0
    t.integer  "quest_75_num_started_day_1",        :default => 0
    t.decimal  "quest_75_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_75_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_75_num_finished",             :default => 0
    t.integer  "quest_75_num_started",              :default => 0
    t.decimal  "quest_75_playtime_finished",        :default => 0.0
    t.decimal  "quest_75_playtime_started",         :default => 0.0
    t.decimal  "quest_75_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_76_num_finished_day_1",       :default => 0
    t.integer  "quest_76_num_started_day_1",        :default => 0
    t.decimal  "quest_76_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_76_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_76_num_finished",             :default => 0
    t.integer  "quest_76_num_started",              :default => 0
    t.decimal  "quest_76_playtime_finished",        :default => 0.0
    t.decimal  "quest_76_playtime_started",         :default => 0.0
    t.decimal  "quest_76_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_77_num_finished_day_1",       :default => 0
    t.integer  "quest_77_num_started_day_1",        :default => 0
    t.decimal  "quest_77_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_77_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_77_num_finished",             :default => 0
    t.integer  "quest_77_num_started",              :default => 0
    t.decimal  "quest_77_playtime_finished",        :default => 0.0
    t.decimal  "quest_77_playtime_started",         :default => 0.0
    t.decimal  "quest_77_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_78_num_finished_day_1",       :default => 0
    t.integer  "quest_78_num_started_day_1",        :default => 0
    t.decimal  "quest_78_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_78_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_78_num_finished",             :default => 0
    t.integer  "quest_78_num_started",              :default => 0
    t.decimal  "quest_78_playtime_finished",        :default => 0.0
    t.decimal  "quest_78_playtime_started",         :default => 0.0
    t.decimal  "quest_78_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_79_num_finished_day_1",       :default => 0
    t.integer  "quest_79_num_started_day_1",        :default => 0
    t.decimal  "quest_79_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_79_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_79_num_finished",             :default => 0
    t.integer  "quest_79_num_started",              :default => 0
    t.decimal  "quest_79_playtime_finished",        :default => 0.0
    t.decimal  "quest_79_playtime_started",         :default => 0.0
    t.decimal  "quest_79_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_80_num_finished_day_1",       :default => 0
    t.integer  "quest_80_num_started_day_1",        :default => 0
    t.decimal  "quest_80_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_80_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_80_num_finished",             :default => 0
    t.integer  "quest_80_num_started",              :default => 0
    t.decimal  "quest_80_playtime_finished",        :default => 0.0
    t.decimal  "quest_80_playtime_started",         :default => 0.0
    t.decimal  "quest_80_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_81_num_finished_day_1",       :default => 0
    t.integer  "quest_81_num_started_day_1",        :default => 0
    t.decimal  "quest_81_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_81_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_81_num_finished",             :default => 0
    t.integer  "quest_81_num_started",              :default => 0
    t.decimal  "quest_81_playtime_finished",        :default => 0.0
    t.decimal  "quest_81_playtime_started",         :default => 0.0
    t.decimal  "quest_81_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_82_num_finished_day_1",       :default => 0
    t.integer  "quest_82_num_started_day_1",        :default => 0
    t.decimal  "quest_82_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_82_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_82_num_finished",             :default => 0
    t.integer  "quest_82_num_started",              :default => 0
    t.decimal  "quest_82_playtime_finished",        :default => 0.0
    t.decimal  "quest_82_playtime_started",         :default => 0.0
    t.decimal  "quest_82_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_83_num_finished_day_1",       :default => 0
    t.integer  "quest_83_num_started_day_1",        :default => 0
    t.decimal  "quest_83_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_83_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_83_num_finished",             :default => 0
    t.integer  "quest_83_num_started",              :default => 0
    t.decimal  "quest_83_playtime_finished",        :default => 0.0
    t.decimal  "quest_83_playtime_started",         :default => 0.0
    t.decimal  "quest_83_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_84_num_finished_day_1",       :default => 0
    t.integer  "quest_84_num_started_day_1",        :default => 0
    t.decimal  "quest_84_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_84_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_84_num_finished",             :default => 0
    t.integer  "quest_84_num_started",              :default => 0
    t.decimal  "quest_84_playtime_finished",        :default => 0.0
    t.decimal  "quest_84_playtime_started",         :default => 0.0
    t.decimal  "quest_84_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_85_num_finished_day_1",       :default => 0
    t.integer  "quest_85_num_started_day_1",        :default => 0
    t.decimal  "quest_85_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_85_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_85_num_finished",             :default => 0
    t.integer  "quest_85_num_started",              :default => 0
    t.decimal  "quest_85_playtime_finished",        :default => 0.0
    t.decimal  "quest_85_playtime_started",         :default => 0.0
    t.decimal  "quest_85_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_86_num_finished_day_1",       :default => 0
    t.integer  "quest_86_num_started_day_1",        :default => 0
    t.decimal  "quest_86_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_86_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_86_num_finished",             :default => 0
    t.integer  "quest_86_num_started",              :default => 0
    t.decimal  "quest_86_playtime_finished",        :default => 0.0
    t.decimal  "quest_86_playtime_started",         :default => 0.0
    t.decimal  "quest_86_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_87_num_finished_day_1",       :default => 0
    t.integer  "quest_87_num_started_day_1",        :default => 0
    t.decimal  "quest_87_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_87_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_87_num_finished",             :default => 0
    t.integer  "quest_87_num_started",              :default => 0
    t.decimal  "quest_87_playtime_finished",        :default => 0.0
    t.decimal  "quest_87_playtime_started",         :default => 0.0
    t.decimal  "quest_87_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_88_num_finished_day_1",       :default => 0
    t.integer  "quest_88_num_started_day_1",        :default => 0
    t.decimal  "quest_88_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_88_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_88_num_finished",             :default => 0
    t.integer  "quest_88_num_started",              :default => 0
    t.decimal  "quest_88_playtime_finished",        :default => 0.0
    t.decimal  "quest_88_playtime_started",         :default => 0.0
    t.decimal  "quest_88_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_89_num_finished_day_1",       :default => 0
    t.integer  "quest_89_num_started_day_1",        :default => 0
    t.decimal  "quest_89_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_89_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_89_num_finished",             :default => 0
    t.integer  "quest_89_num_started",              :default => 0
    t.decimal  "quest_89_playtime_finished",        :default => 0.0
    t.decimal  "quest_89_playtime_started",         :default => 0.0
    t.decimal  "quest_89_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_90_num_finished_day_1",       :default => 0
    t.integer  "quest_90_num_started_day_1",        :default => 0
    t.decimal  "quest_90_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_90_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_90_num_finished",             :default => 0
    t.integer  "quest_90_num_started",              :default => 0
    t.decimal  "quest_90_playtime_finished",        :default => 0.0
    t.decimal  "quest_90_playtime_started",         :default => 0.0
    t.decimal  "quest_90_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_91_num_finished_day_1",       :default => 0
    t.integer  "quest_91_num_started_day_1",        :default => 0
    t.decimal  "quest_91_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_91_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_91_num_finished",             :default => 0
    t.integer  "quest_91_num_started",              :default => 0
    t.decimal  "quest_91_playtime_finished",        :default => 0.0
    t.decimal  "quest_91_playtime_started",         :default => 0.0
    t.decimal  "quest_91_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_92_num_finished_day_1",       :default => 0
    t.integer  "quest_92_num_started_day_1",        :default => 0
    t.decimal  "quest_92_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_92_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_92_num_finished",             :default => 0
    t.integer  "quest_92_num_started",              :default => 0
    t.decimal  "quest_92_playtime_finished",        :default => 0.0
    t.decimal  "quest_92_playtime_started",         :default => 0.0
    t.decimal  "quest_92_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_93_num_finished_day_1",       :default => 0
    t.integer  "quest_93_num_started_day_1",        :default => 0
    t.decimal  "quest_93_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_93_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_93_num_finished",             :default => 0
    t.integer  "quest_93_num_started",              :default => 0
    t.decimal  "quest_93_playtime_finished",        :default => 0.0
    t.decimal  "quest_93_playtime_started",         :default => 0.0
    t.decimal  "quest_93_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_94_num_finished_day_1",       :default => 0
    t.integer  "quest_94_num_started_day_1",        :default => 0
    t.decimal  "quest_94_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_94_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_94_num_finished",             :default => 0
    t.integer  "quest_94_num_started",              :default => 0
    t.decimal  "quest_94_playtime_finished",        :default => 0.0
    t.decimal  "quest_94_playtime_started",         :default => 0.0
    t.decimal  "quest_94_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_95_num_finished_day_1",       :default => 0
    t.integer  "quest_95_num_started_day_1",        :default => 0
    t.decimal  "quest_95_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_95_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_95_num_finished",             :default => 0
    t.integer  "quest_95_num_started",              :default => 0
    t.decimal  "quest_95_playtime_finished",        :default => 0.0
    t.decimal  "quest_95_playtime_started",         :default => 0.0
    t.decimal  "quest_95_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_96_num_finished_day_1",       :default => 0
    t.integer  "quest_96_num_started_day_1",        :default => 0
    t.decimal  "quest_96_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_96_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_96_num_finished",             :default => 0
    t.integer  "quest_96_num_started",              :default => 0
    t.decimal  "quest_96_playtime_finished",        :default => 0.0
    t.decimal  "quest_96_playtime_started",         :default => 0.0
    t.decimal  "quest_96_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_97_num_finished_day_1",       :default => 0
    t.integer  "quest_97_num_started_day_1",        :default => 0
    t.decimal  "quest_97_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_97_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_97_num_finished",             :default => 0
    t.integer  "quest_97_num_started",              :default => 0
    t.decimal  "quest_97_playtime_finished",        :default => 0.0
    t.decimal  "quest_97_playtime_started",         :default => 0.0
    t.decimal  "quest_97_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_98_num_finished_day_1",       :default => 0
    t.integer  "quest_98_num_started_day_1",        :default => 0
    t.decimal  "quest_98_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_98_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_98_num_finished",             :default => 0
    t.integer  "quest_98_num_started",              :default => 0
    t.decimal  "quest_98_playtime_finished",        :default => 0.0
    t.decimal  "quest_98_playtime_started",         :default => 0.0
    t.decimal  "quest_98_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_99_num_finished_day_1",       :default => 0
    t.integer  "quest_99_num_started_day_1",        :default => 0
    t.decimal  "quest_99_playtime_finished_day_1",  :default => 0.0
    t.decimal  "quest_99_playtime_started_day_1",   :default => 0.0
    t.integer  "quest_99_num_finished",             :default => 0
    t.integer  "quest_99_num_started",              :default => 0
    t.decimal  "quest_99_playtime_finished",        :default => 0.0
    t.decimal  "quest_99_playtime_started",         :default => 0.0
    t.decimal  "quest_99_retention_rate_week_1",    :default => 0.0
    t.integer  "quest_100_num_finished_day_1",      :default => 0
    t.integer  "quest_100_num_started_day_1",       :default => 0
    t.decimal  "quest_100_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_100_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_100_num_finished",            :default => 0
    t.integer  "quest_100_num_started",             :default => 0
    t.decimal  "quest_100_playtime_finished",       :default => 0.0
    t.decimal  "quest_100_playtime_started",        :default => 0.0
    t.decimal  "quest_100_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_101_num_finished_day_1",      :default => 0
    t.integer  "quest_101_num_started_day_1",       :default => 0
    t.decimal  "quest_101_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_101_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_101_num_finished",            :default => 0
    t.integer  "quest_101_num_started",             :default => 0
    t.decimal  "quest_101_playtime_finished",       :default => 0.0
    t.decimal  "quest_101_playtime_started",        :default => 0.0
    t.decimal  "quest_101_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_102_num_finished_day_1",      :default => 0
    t.integer  "quest_102_num_started_day_1",       :default => 0
    t.decimal  "quest_102_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_102_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_102_num_finished",            :default => 0
    t.integer  "quest_102_num_started",             :default => 0
    t.decimal  "quest_102_playtime_finished",       :default => 0.0
    t.decimal  "quest_102_playtime_started",        :default => 0.0
    t.decimal  "quest_102_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_103_num_finished_day_1",      :default => 0
    t.integer  "quest_103_num_started_day_1",       :default => 0
    t.decimal  "quest_103_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_103_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_103_num_finished",            :default => 0
    t.integer  "quest_103_num_started",             :default => 0
    t.decimal  "quest_103_playtime_finished",       :default => 0.0
    t.decimal  "quest_103_playtime_started",        :default => 0.0
    t.decimal  "quest_103_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_104_num_finished_day_1",      :default => 0
    t.integer  "quest_104_num_started_day_1",       :default => 0
    t.decimal  "quest_104_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_104_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_104_num_finished",            :default => 0
    t.integer  "quest_104_num_started",             :default => 0
    t.decimal  "quest_104_playtime_finished",       :default => 0.0
    t.decimal  "quest_104_playtime_started",        :default => 0.0
    t.decimal  "quest_104_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_105_num_finished_day_1",      :default => 0
    t.integer  "quest_105_num_started_day_1",       :default => 0
    t.decimal  "quest_105_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_105_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_105_num_finished",            :default => 0
    t.integer  "quest_105_num_started",             :default => 0
    t.decimal  "quest_105_playtime_finished",       :default => 0.0
    t.decimal  "quest_105_playtime_started",        :default => 0.0
    t.decimal  "quest_105_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_106_num_finished_day_1",      :default => 0
    t.integer  "quest_106_num_started_day_1",       :default => 0
    t.decimal  "quest_106_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_106_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_106_num_finished",            :default => 0
    t.integer  "quest_106_num_started",             :default => 0
    t.decimal  "quest_106_playtime_finished",       :default => 0.0
    t.decimal  "quest_106_playtime_started",        :default => 0.0
    t.decimal  "quest_106_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_107_num_finished_day_1",      :default => 0
    t.integer  "quest_107_num_started_day_1",       :default => 0
    t.decimal  "quest_107_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_107_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_107_num_finished",            :default => 0
    t.integer  "quest_107_num_started",             :default => 0
    t.decimal  "quest_107_playtime_finished",       :default => 0.0
    t.decimal  "quest_107_playtime_started",        :default => 0.0
    t.decimal  "quest_107_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_108_num_finished_day_1",      :default => 0
    t.integer  "quest_108_num_started_day_1",       :default => 0
    t.decimal  "quest_108_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_108_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_108_num_finished",            :default => 0
    t.integer  "quest_108_num_started",             :default => 0
    t.decimal  "quest_108_playtime_finished",       :default => 0.0
    t.decimal  "quest_108_playtime_started",        :default => 0.0
    t.decimal  "quest_108_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_109_num_finished_day_1",      :default => 0
    t.integer  "quest_109_num_started_day_1",       :default => 0
    t.decimal  "quest_109_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_109_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_109_num_finished",            :default => 0
    t.integer  "quest_109_num_started",             :default => 0
    t.decimal  "quest_109_playtime_finished",       :default => 0.0
    t.decimal  "quest_109_playtime_started",        :default => 0.0
    t.decimal  "quest_109_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_110_num_finished_day_1",      :default => 0
    t.integer  "quest_110_num_started_day_1",       :default => 0
    t.decimal  "quest_110_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_110_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_110_num_finished",            :default => 0
    t.integer  "quest_110_num_started",             :default => 0
    t.decimal  "quest_110_playtime_finished",       :default => 0.0
    t.decimal  "quest_110_playtime_started",        :default => 0.0
    t.decimal  "quest_110_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_111_num_finished_day_1",      :default => 0
    t.integer  "quest_111_num_started_day_1",       :default => 0
    t.decimal  "quest_111_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_111_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_111_num_finished",            :default => 0
    t.integer  "quest_111_num_started",             :default => 0
    t.decimal  "quest_111_playtime_finished",       :default => 0.0
    t.decimal  "quest_111_playtime_started",        :default => 0.0
    t.decimal  "quest_111_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_112_num_finished_day_1",      :default => 0
    t.integer  "quest_112_num_started_day_1",       :default => 0
    t.decimal  "quest_112_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_112_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_112_num_finished",            :default => 0
    t.integer  "quest_112_num_started",             :default => 0
    t.decimal  "quest_112_playtime_finished",       :default => 0.0
    t.decimal  "quest_112_playtime_started",        :default => 0.0
    t.decimal  "quest_112_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_113_num_finished_day_1",      :default => 0
    t.integer  "quest_113_num_started_day_1",       :default => 0
    t.decimal  "quest_113_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_113_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_113_num_finished",            :default => 0
    t.integer  "quest_113_num_started",             :default => 0
    t.decimal  "quest_113_playtime_finished",       :default => 0.0
    t.decimal  "quest_113_playtime_started",        :default => 0.0
    t.decimal  "quest_113_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_114_num_finished_day_1",      :default => 0
    t.integer  "quest_114_num_started_day_1",       :default => 0
    t.decimal  "quest_114_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_114_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_114_num_finished",            :default => 0
    t.integer  "quest_114_num_started",             :default => 0
    t.decimal  "quest_114_playtime_finished",       :default => 0.0
    t.decimal  "quest_114_playtime_started",        :default => 0.0
    t.decimal  "quest_114_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_115_num_finished_day_1",      :default => 0
    t.integer  "quest_115_num_started_day_1",       :default => 0
    t.decimal  "quest_115_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_115_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_115_num_finished",            :default => 0
    t.integer  "quest_115_num_started",             :default => 0
    t.decimal  "quest_115_playtime_finished",       :default => 0.0
    t.decimal  "quest_115_playtime_started",        :default => 0.0
    t.decimal  "quest_115_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_116_num_finished_day_1",      :default => 0
    t.integer  "quest_116_num_started_day_1",       :default => 0
    t.decimal  "quest_116_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_116_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_116_num_finished",            :default => 0
    t.integer  "quest_116_num_started",             :default => 0
    t.decimal  "quest_116_playtime_finished",       :default => 0.0
    t.decimal  "quest_116_playtime_started",        :default => 0.0
    t.decimal  "quest_116_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_117_num_finished_day_1",      :default => 0
    t.integer  "quest_117_num_started_day_1",       :default => 0
    t.decimal  "quest_117_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_117_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_117_num_finished",            :default => 0
    t.integer  "quest_117_num_started",             :default => 0
    t.decimal  "quest_117_playtime_finished",       :default => 0.0
    t.decimal  "quest_117_playtime_started",        :default => 0.0
    t.decimal  "quest_117_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_118_num_finished_day_1",      :default => 0
    t.integer  "quest_118_num_started_day_1",       :default => 0
    t.decimal  "quest_118_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_118_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_118_num_finished",            :default => 0
    t.integer  "quest_118_num_started",             :default => 0
    t.decimal  "quest_118_playtime_finished",       :default => 0.0
    t.decimal  "quest_118_playtime_started",        :default => 0.0
    t.decimal  "quest_118_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_119_num_finished_day_1",      :default => 0
    t.integer  "quest_119_num_started_day_1",       :default => 0
    t.decimal  "quest_119_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_119_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_119_num_finished",            :default => 0
    t.integer  "quest_119_num_started",             :default => 0
    t.decimal  "quest_119_playtime_finished",       :default => 0.0
    t.decimal  "quest_119_playtime_started",        :default => 0.0
    t.decimal  "quest_119_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_120_num_finished_day_1",      :default => 0
    t.integer  "quest_120_num_started_day_1",       :default => 0
    t.decimal  "quest_120_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_120_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_120_num_finished",            :default => 0
    t.integer  "quest_120_num_started",             :default => 0
    t.decimal  "quest_120_playtime_finished",       :default => 0.0
    t.decimal  "quest_120_playtime_started",        :default => 0.0
    t.decimal  "quest_120_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_121_num_finished_day_1",      :default => 0
    t.integer  "quest_121_num_started_day_1",       :default => 0
    t.decimal  "quest_121_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_121_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_121_num_finished",            :default => 0
    t.integer  "quest_121_num_started",             :default => 0
    t.decimal  "quest_121_playtime_finished",       :default => 0.0
    t.decimal  "quest_121_playtime_started",        :default => 0.0
    t.decimal  "quest_121_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_122_num_finished_day_1",      :default => 0
    t.integer  "quest_122_num_started_day_1",       :default => 0
    t.decimal  "quest_122_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_122_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_122_num_finished",            :default => 0
    t.integer  "quest_122_num_started",             :default => 0
    t.decimal  "quest_122_playtime_finished",       :default => 0.0
    t.decimal  "quest_122_playtime_started",        :default => 0.0
    t.decimal  "quest_122_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_123_num_finished_day_1",      :default => 0
    t.integer  "quest_123_num_started_day_1",       :default => 0
    t.decimal  "quest_123_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_123_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_123_num_finished",            :default => 0
    t.integer  "quest_123_num_started",             :default => 0
    t.decimal  "quest_123_playtime_finished",       :default => 0.0
    t.decimal  "quest_123_playtime_started",        :default => 0.0
    t.decimal  "quest_123_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_124_num_finished_day_1",      :default => 0
    t.integer  "quest_124_num_started_day_1",       :default => 0
    t.decimal  "quest_124_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_124_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_124_num_finished",            :default => 0
    t.integer  "quest_124_num_started",             :default => 0
    t.decimal  "quest_124_playtime_finished",       :default => 0.0
    t.decimal  "quest_124_playtime_started",        :default => 0.0
    t.decimal  "quest_124_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_125_num_finished_day_1",      :default => 0
    t.integer  "quest_125_num_started_day_1",       :default => 0
    t.decimal  "quest_125_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_125_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_125_num_finished",            :default => 0
    t.integer  "quest_125_num_started",             :default => 0
    t.decimal  "quest_125_playtime_finished",       :default => 0.0
    t.decimal  "quest_125_playtime_started",        :default => 0.0
    t.decimal  "quest_125_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_126_num_finished_day_1",      :default => 0
    t.integer  "quest_126_num_started_day_1",       :default => 0
    t.decimal  "quest_126_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_126_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_126_num_finished",            :default => 0
    t.integer  "quest_126_num_started",             :default => 0
    t.decimal  "quest_126_playtime_finished",       :default => 0.0
    t.decimal  "quest_126_playtime_started",        :default => 0.0
    t.decimal  "quest_126_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_127_num_finished_day_1",      :default => 0
    t.integer  "quest_127_num_started_day_1",       :default => 0
    t.decimal  "quest_127_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_127_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_127_num_finished",            :default => 0
    t.integer  "quest_127_num_started",             :default => 0
    t.decimal  "quest_127_playtime_finished",       :default => 0.0
    t.decimal  "quest_127_playtime_started",        :default => 0.0
    t.decimal  "quest_127_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_128_num_finished_day_1",      :default => 0
    t.integer  "quest_128_num_started_day_1",       :default => 0
    t.decimal  "quest_128_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_128_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_128_num_finished",            :default => 0
    t.integer  "quest_128_num_started",             :default => 0
    t.decimal  "quest_128_playtime_finished",       :default => 0.0
    t.decimal  "quest_128_playtime_started",        :default => 0.0
    t.decimal  "quest_128_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_129_num_finished_day_1",      :default => 0
    t.integer  "quest_129_num_started_day_1",       :default => 0
    t.decimal  "quest_129_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_129_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_129_num_finished",            :default => 0
    t.integer  "quest_129_num_started",             :default => 0
    t.decimal  "quest_129_playtime_finished",       :default => 0.0
    t.decimal  "quest_129_playtime_started",        :default => 0.0
    t.decimal  "quest_129_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_130_num_finished_day_1",      :default => 0
    t.integer  "quest_130_num_started_day_1",       :default => 0
    t.decimal  "quest_130_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_130_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_130_num_finished",            :default => 0
    t.integer  "quest_130_num_started",             :default => 0
    t.decimal  "quest_130_playtime_finished",       :default => 0.0
    t.decimal  "quest_130_playtime_started",        :default => 0.0
    t.decimal  "quest_130_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_131_num_finished_day_1",      :default => 0
    t.integer  "quest_131_num_started_day_1",       :default => 0
    t.decimal  "quest_131_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_131_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_131_num_finished",            :default => 0
    t.integer  "quest_131_num_started",             :default => 0
    t.decimal  "quest_131_playtime_finished",       :default => 0.0
    t.decimal  "quest_131_playtime_started",        :default => 0.0
    t.decimal  "quest_131_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_132_num_finished_day_1",      :default => 0
    t.integer  "quest_132_num_started_day_1",       :default => 0
    t.decimal  "quest_132_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_132_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_132_num_finished",            :default => 0
    t.integer  "quest_132_num_started",             :default => 0
    t.decimal  "quest_132_playtime_finished",       :default => 0.0
    t.decimal  "quest_132_playtime_started",        :default => 0.0
    t.decimal  "quest_132_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_133_num_finished_day_1",      :default => 0
    t.integer  "quest_133_num_started_day_1",       :default => 0
    t.decimal  "quest_133_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_133_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_133_num_finished",            :default => 0
    t.integer  "quest_133_num_started",             :default => 0
    t.decimal  "quest_133_playtime_finished",       :default => 0.0
    t.decimal  "quest_133_playtime_started",        :default => 0.0
    t.decimal  "quest_133_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_134_num_finished_day_1",      :default => 0
    t.integer  "quest_134_num_started_day_1",       :default => 0
    t.decimal  "quest_134_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_134_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_134_num_finished",            :default => 0
    t.integer  "quest_134_num_started",             :default => 0
    t.decimal  "quest_134_playtime_finished",       :default => 0.0
    t.decimal  "quest_134_playtime_started",        :default => 0.0
    t.decimal  "quest_134_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_135_num_finished_day_1",      :default => 0
    t.integer  "quest_135_num_started_day_1",       :default => 0
    t.decimal  "quest_135_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_135_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_135_num_finished",            :default => 0
    t.integer  "quest_135_num_started",             :default => 0
    t.decimal  "quest_135_playtime_finished",       :default => 0.0
    t.decimal  "quest_135_playtime_started",        :default => 0.0
    t.decimal  "quest_135_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_136_num_finished_day_1",      :default => 0
    t.integer  "quest_136_num_started_day_1",       :default => 0
    t.decimal  "quest_136_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_136_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_136_num_finished",            :default => 0
    t.integer  "quest_136_num_started",             :default => 0
    t.decimal  "quest_136_playtime_finished",       :default => 0.0
    t.decimal  "quest_136_playtime_started",        :default => 0.0
    t.decimal  "quest_136_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_137_num_finished_day_1",      :default => 0
    t.integer  "quest_137_num_started_day_1",       :default => 0
    t.decimal  "quest_137_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_137_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_137_num_finished",            :default => 0
    t.integer  "quest_137_num_started",             :default => 0
    t.decimal  "quest_137_playtime_finished",       :default => 0.0
    t.decimal  "quest_137_playtime_started",        :default => 0.0
    t.decimal  "quest_137_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_138_num_finished_day_1",      :default => 0
    t.integer  "quest_138_num_started_day_1",       :default => 0
    t.decimal  "quest_138_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_138_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_138_num_finished",            :default => 0
    t.integer  "quest_138_num_started",             :default => 0
    t.decimal  "quest_138_playtime_finished",       :default => 0.0
    t.decimal  "quest_138_playtime_started",        :default => 0.0
    t.decimal  "quest_138_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_139_num_finished_day_1",      :default => 0
    t.integer  "quest_139_num_started_day_1",       :default => 0
    t.decimal  "quest_139_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_139_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_139_num_finished",            :default => 0
    t.integer  "quest_139_num_started",             :default => 0
    t.decimal  "quest_139_playtime_finished",       :default => 0.0
    t.decimal  "quest_139_playtime_started",        :default => 0.0
    t.decimal  "quest_139_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_140_num_finished_day_1",      :default => 0
    t.integer  "quest_140_num_started_day_1",       :default => 0
    t.decimal  "quest_140_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_140_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_140_num_finished",            :default => 0
    t.integer  "quest_140_num_started",             :default => 0
    t.decimal  "quest_140_playtime_finished",       :default => 0.0
    t.decimal  "quest_140_playtime_started",        :default => 0.0
    t.decimal  "quest_140_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_141_num_finished_day_1",      :default => 0
    t.integer  "quest_141_num_started_day_1",       :default => 0
    t.decimal  "quest_141_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_141_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_141_num_finished",            :default => 0
    t.integer  "quest_141_num_started",             :default => 0
    t.decimal  "quest_141_playtime_finished",       :default => 0.0
    t.decimal  "quest_141_playtime_started",        :default => 0.0
    t.decimal  "quest_141_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_142_num_finished_day_1",      :default => 0
    t.integer  "quest_142_num_started_day_1",       :default => 0
    t.decimal  "quest_142_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_142_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_142_num_finished",            :default => 0
    t.integer  "quest_142_num_started",             :default => 0
    t.decimal  "quest_142_playtime_finished",       :default => 0.0
    t.decimal  "quest_142_playtime_started",        :default => 0.0
    t.decimal  "quest_142_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_143_num_finished_day_1",      :default => 0
    t.integer  "quest_143_num_started_day_1",       :default => 0
    t.decimal  "quest_143_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_143_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_143_num_finished",            :default => 0
    t.integer  "quest_143_num_started",             :default => 0
    t.decimal  "quest_143_playtime_finished",       :default => 0.0
    t.decimal  "quest_143_playtime_started",        :default => 0.0
    t.decimal  "quest_143_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_144_num_finished_day_1",      :default => 0
    t.integer  "quest_144_num_started_day_1",       :default => 0
    t.decimal  "quest_144_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_144_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_144_num_finished",            :default => 0
    t.integer  "quest_144_num_started",             :default => 0
    t.decimal  "quest_144_playtime_finished",       :default => 0.0
    t.decimal  "quest_144_playtime_started",        :default => 0.0
    t.decimal  "quest_144_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_145_num_finished_day_1",      :default => 0
    t.integer  "quest_145_num_started_day_1",       :default => 0
    t.decimal  "quest_145_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_145_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_145_num_finished",            :default => 0
    t.integer  "quest_145_num_started",             :default => 0
    t.decimal  "quest_145_playtime_finished",       :default => 0.0
    t.decimal  "quest_145_playtime_started",        :default => 0.0
    t.decimal  "quest_145_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_146_num_finished_day_1",      :default => 0
    t.integer  "quest_146_num_started_day_1",       :default => 0
    t.decimal  "quest_146_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_146_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_146_num_finished",            :default => 0
    t.integer  "quest_146_num_started",             :default => 0
    t.decimal  "quest_146_playtime_finished",       :default => 0.0
    t.decimal  "quest_146_playtime_started",        :default => 0.0
    t.decimal  "quest_146_retention_rate_week_1",   :default => 0.0
    t.integer  "quest_147_num_finished_day_1",      :default => 0
    t.integer  "quest_147_num_started_day_1",       :default => 0
    t.decimal  "quest_147_playtime_finished_day_1", :default => 0.0
    t.decimal  "quest_147_playtime_started_day_1",  :default => 0.0
    t.integer  "quest_147_num_finished",            :default => 0
    t.integer  "quest_147_num_started",             :default => 0
    t.decimal  "quest_147_playtime_finished",       :default => 0.0
    t.decimal  "quest_147_playtime_started",        :default => 0.0
    t.decimal  "quest_147_retention_rate_week_1",   :default => 0.0
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
    t.boolean  "partner"
    t.boolean  "developer",          :default => false, :null => false
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

  create_table "effect_alliance_construction_effects", :force => true do |t|
    t.datetime "finished_at"
    t.integer  "type_id"
    t.decimal  "bonus"
    t.integer  "alliance_id"
    t.integer  "origin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "effect_alliance_resource_effects", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "type_id"
    t.decimal  "bonus"
    t.integer  "alliance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "origin_id"
  end

  create_table "effect_construction_effects", :force => true do |t|
    t.datetime "finished_at"
    t.integer  "type_id"
    t.decimal  "bonus"
    t.integer  "character_id"
    t.integer  "origin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "effect_resource_effects", :force => true do |t|
    t.integer  "resource_id"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_id"
    t.decimal  "bonus"
    t.integer  "resource_pool_id"
    t.integer  "origin_id"
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

  create_table "fundamental_alliance_reservations", :force => true do |t|
    t.integer  "alliance_id"
    t.string   "tag"
    t.string   "name"
    t.string   "password"
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
    t.string   "invitation_code"
    t.decimal  "resource_stone_production_bonus_effects",       :default => 0.0
    t.decimal  "resource_wood_production_bonus_effects",        :default => 0.0
    t.decimal  "resource_fur_production_bonus_effects",         :default => 0.0
    t.decimal  "resource_cash_production_bonus_effects",        :default => 0.0
    t.integer  "size_bonus",                                    :default => 0
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

  create_table "fundamental_artifact_initiations", :force => true do |t|
    t.integer  "artifact_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hurried",     :default => false, :null => false
  end

  create_table "fundamental_artifacts", :force => true do |t|
    t.integer  "location_id"
    t.integer  "settlement_id"
    t.integer  "owner_id"
    t.boolean  "initiated"
    t.datetime "last_initiated_at"
    t.datetime "last_captured_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "region_id"
    t.integer  "type_id"
    t.boolean  "visible"
    t.integer  "alliance_id"
    t.integer  "army_id"
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
    t.decimal  "gross",                                    :default => 0.0
    t.decimal  "playtime",                                 :default => 0.0,   :null => false
    t.integer  "notified_mundane_rank",                    :default => 0,     :null => false
    t.integer  "notified_sacred_rank",                     :default => 0,     :null => false
    t.string   "staff_roles"
    t.integer  "last_retention_mail_id"
    t.datetime "last_retention_mail_sent_at"
    t.integer  "kills",                                    :default => 0,     :null => false
    t.integer  "victories",                                :default => 0,     :null => false
    t.integer  "defeats",                                  :default => 0,     :null => false
    t.decimal  "exp_production_rate",                      :default => 0.0,   :null => false
    t.decimal  "exp_building_production_rate",             :default => 0.0,   :null => false
    t.datetime "production_updated_at"
    t.integer  "send_likes_count",                         :default => 0
    t.integer  "received_likes_count",                     :default => 0
    t.integer  "send_dislikes_count",                      :default => 0
    t.integer  "received_dislikes_count",                  :default => 0
    t.string   "same_ip"
    t.boolean  "deleted_from_game",                        :default => false
    t.datetime "last_deleted_at"
    t.integer  "alliance_size_bonus",                      :default => 0
    t.string   "lang",                                     :default => "en",  :null => false
    t.string   "avatar_string"
    t.datetime "insider_since"
    t.boolean  "first_round"
    t.datetime "tutorial_finished_at"
    t.decimal  "construction_bonus_effect",                :default => 0.0,   :null => false
    t.decimal  "construction_bonus_total",                 :default => 0.0,   :null => false
    t.integer  "assignment_level",                         :default => 0,     :null => false
    t.datetime "premium_expiration_displayed_at"
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

  create_table "fundamental_history_events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "character_id"
    t.text     "data"
    t.text     "localized_description"
  end

  create_table "fundamental_resource_pools", :force => true do |t|
    t.integer  "character_id"
    t.datetime "locked_at"
    t.string   "locked_by"
    t.string   "locked_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "productionUpdatedAt"
    t.decimal  "resource_wood_amount",                     :default => 0.0
    t.decimal  "resource_wood_capacity",                   :default => 0.0
    t.decimal  "resource_wood_production_rate",            :default => 0.0
    t.decimal  "resource_stone_amount",                    :default => 0.0
    t.decimal  "resource_stone_capacity",                  :default => 0.0
    t.decimal  "resource_stone_production_rate",           :default => 0.0
    t.decimal  "resource_fur_amount",                      :default => 0.0
    t.decimal  "resource_fur_capacity",                    :default => 0.0
    t.decimal  "resource_fur_production_rate",             :default => 0.0
    t.decimal  "resource_cash_amount",                     :default => 0.0
    t.decimal  "resource_cash_capacity",                   :default => 0.0
    t.decimal  "resource_cash_production_rate",            :default => 0.0
    t.decimal  "resource_wood_production_bonus_effects",   :default => 0.0
    t.decimal  "resource_stone_production_bonus_effects",  :default => 0.0
    t.decimal  "resource_fur_production_bonus_effects",    :default => 0.0
    t.decimal  "resource_cash_production_bonus_effects",   :default => 0.0
    t.decimal  "like_amount",                              :default => 0.0
    t.decimal  "dislike_amount",                           :default => 0.0
    t.datetime "lazy_production_updated_at"
    t.decimal  "resource_stone_production_bonus_alliance", :default => 0.0
    t.decimal  "resource_wood_production_bonus_alliance",  :default => 0.0
    t.decimal  "resource_fur_production_bonus_alliance",   :default => 0.0
    t.decimal  "resource_cash_production_bonus_alliance",  :default => 0.0
  end

  create_table "fundamental_retention_mails", :force => true do |t|
    t.integer  "character_id"
    t.string   "mail_type"
    t.string   "identifier"
    t.datetime "redeemed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credit_reward", :default => 0, :null => false
  end

  create_table "fundamental_round_infos", :force => true do |t|
    t.string   "name"
    t.datetime "started_at"
    t.integer  "regions_count",       :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "victory_gained_at"
    t.integer  "winner_alliance_id"
    t.integer  "number",              :default => 0, :null => false
    t.integer  "victory_type"
    t.string   "winner_alliance_tag"
  end

  create_table "fundamental_settings", :force => true do |t|
    t.boolean  "email_messages", :default => true, :null => false
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fundamental_victory_progresses", :force => true do |t|
    t.integer  "type_id",                           :null => false
    t.integer  "alliance_id"
    t.datetime "first_fulfilled_at"
    t.integer  "fulfillment_count",  :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "victory_gained"
  end

  create_table "like_system_dislikes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id",   :default => 0
    t.integer  "receiver_id", :default => 0
  end

  create_table "like_system_likes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id",   :default => 0
    t.integer  "receiver_id", :default => 0
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
    t.string   "avatar_string"
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
    t.string   "invitation_code"
    t.string   "avatar_string"
  end

  add_index "map_regions", ["node_id"], :name => "index_map_regions_on_node_id"

  create_table "messaging_archive_entries", :force => true do |t|
    t.integer  "archive_id"
    t.integer  "recipient_id"
    t.integer  "message_id"
    t.integer  "sender_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_id",      :default => 0, :null => false
    t.integer  "owner_id"
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
    t.datetime "suspension_ends_at"
    t.datetime "attack_protection_ends_at"
    t.decimal  "ap_rate",                         :default => 1.0,   :null => false
    t.string   "avatar_string"
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
    t.integer  "unit_warrior"
  end

  create_table "military_battle_character_results", :force => true do |t|
    t.integer  "battle_id"
    t.integer  "character_id"
    t.integer  "faction_id"
    t.decimal  "experience_gained", :default => 0.0,   :null => false
    t.boolean  "winner",            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.decimal  "unitcategory_special_strength",   :default => 0.0,   :null => false
    t.boolean  "winner",                          :default => false
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
    t.integer  "participant_id"
    t.integer  "unit_warrior"
    t.integer  "unit_warrior_casualties"
    t.decimal  "unit_warrior_damage_taken"
    t.decimal  "unit_warrior_damage_inflicted"
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
    t.integer  "character_id"
    t.integer  "total_kills",              :default => 0, :null => false
    t.integer  "num_rounds",               :default => 0, :null => false
    t.string   "army_name"
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
    t.integer  "kills",            :default => 0, :null => false
    t.integer  "kills_rank"
  end

  create_table "ranking_character_rankings", :force => true do |t|
    t.integer  "character_id"
    t.string   "character_name"
    t.integer  "alliance_id"
    t.string   "alliance_tag"
    t.integer  "overall_score",            :default => 0,   :null => false
    t.integer  "overall_rank"
    t.integer  "resource_score",           :default => 0,   :null => false
    t.integer  "resource_rank"
    t.integer  "power_score",              :default => 0,   :null => false
    t.integer  "power_rank"
    t.integer  "num_settlements",          :default => 0,   :null => false
    t.integer  "settlements_rank"
    t.integer  "num_outposts",             :default => 0,   :null => false
    t.integer  "outposts_rank"
    t.integer  "num_fortress",             :default => 0,   :null => false
    t.integer  "fortress_rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_experience",           :default => 0,   :null => false
    t.integer  "max_experience_rank"
    t.string   "max_experience_army_name"
    t.integer  "max_experience_army_rank"
    t.integer  "max_experience_army_id"
    t.integer  "kills",                    :default => 0,   :null => false
    t.integer  "kills_rank"
    t.integer  "victories",                :default => 0,   :null => false
    t.integer  "defeats",                  :default => 0,   :null => false
    t.decimal  "victory_ratio",            :default => 0.0, :null => false
    t.integer  "likes",                    :default => 0,   :null => false
    t.integer  "dislikes",                 :default => 0,   :null => false
    t.decimal  "like_ratio",               :default => 0.0, :null => false
    t.string   "gender"
    t.string   "avatar_string"
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
    t.decimal  "exp_production_rate",                            :default => 0.0
    t.decimal  "exp_production_rate_buildings",                  :default => 0.0
    t.datetime "last_takeover_at"
    t.integer  "artifact_initiation_level",                      :default => 0,            :null => false
    t.integer  "name_change_count",                              :default => 0
    t.integer  "alliance_size_bonus",                            :default => 0
    t.integer  "assignment_level",                               :default => 0,            :null => false
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
    t.boolean  "sent_mail_alert",          :default => false
    t.boolean  "sent_special_offer_alert"
  end

  add_index "shop_money_transactions", ["uid"], :name => "index_shop_money_transactions_on_uid", :unique => true

  create_table "shop_offers", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "price"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_platinum_offers", :force => true do |t|
    t.string   "title"
    t.integer  "price"
    t.integer  "duration"
    t.datetime "started_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_purchases", :force => true do |t|
    t.string   "offer_type"
    t.integer  "offer_id"
    t.datetime "redeemed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "special_offers_transaction_id"
    t.integer  "character_id"
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

  create_table "shop_special_offers", :force => true do |t|
    t.datetime "startet_at"
    t.datetime "ends_at"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bytro_offer_id"
  end

  create_table "shop_special_offers_transactions", :force => true do |t|
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "character_id"
    t.integer  "state"
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
    t.boolean  "paid",              :default => false, :null => false
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
    t.integer  "status",              :default => 0
    t.datetime "closed_at"
    t.decimal  "playtime_finished"
    t.decimal  "playtime_started"
    t.datetime "reward_displayed_at"
    t.integer  "character_id"
    t.boolean  "message_sent",        :default => false, :null => false
  end

  add_index "tutorial_quests", ["state_id"], :name => "index_tutorial_quests_on_state_id"
  add_index "tutorial_quests", ["status"], :name => "index_tutorial_quests_on_status"

  create_table "tutorial_states", :force => true do |t|
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "tutorial_completed",                      :default => false, :null => false
    t.datetime "displayed_tutorial_completion_notice_at"
    t.integer  "tutorial_states_completed",               :default => 0,     :null => false
    t.boolean  "tutorial_finished",                       :default => false, :null => false
  end

end
