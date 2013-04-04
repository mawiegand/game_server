#!/usr/bin/env ruby

# Reads rules model and prints a wiki compatible
# table with building costs
#
# run in game_server root folder by:
#    rails r script/print_buildings_upgrade_info.rb
# otherwise it won't be able to read the model properly

require 'util/formula'

rules = GameRules::Rules.the_rules

# read building categories first
categories = rules.building_categories
categories.each do |category|
  puts "= #{category[:name][:de_DE]} ="
  buildings = rules.building_types
  buildings.each do |building|

    if building[:category] == category[:id]
      # heading
      puts "== #{building[:name][:de_DE]} ==" 

      # table head
      puts "{| class=\"wikitable\""
      puts "!Level"

      # print resource names required by building
      costs = building[:costs]
      0.upto(costs.count-1) do |resource_id|
        puts "!#{GameRules::Rules.the_rules.resource_types[resource_id][:name][:de_DE]}"
      end
      puts "|-"

      # max level is 20 on standard (id 4) and large (id 5) buildings
      max_building_level = building[:category] == 4 || building[:category] == 5 ? 20 : 10
      1.upto(max_building_level) do |level|
        print "|#{level}"
          costs.each do |resource_id, formula|
          f = Util::Formula.parse_from_formula(formula)
          print "||#{f.apply(level)}"
        end
        puts "\n|-"
      end
      puts "|}\n\n"
    end
  end
end

