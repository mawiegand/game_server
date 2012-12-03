#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))
require 'util/formula'

def check_formula(type, formula)
  return if formula.nil?
  f = Util::Formula.parse_from_formula(formula)
  begin
    f.apply(1).to_s
  rescue
    puts "Error in #{type[:symbolic_id]} formula:"
    puts formula
    exit(1)
  end
end

rules = GameRules::Rules.the_rules

rules.building_types.each do |building_type|
  building_type[:costs].each do |k, v|
    check_formula(building_type, v)
  end
  
  check_formula(building_type, building_type[:production_time])
  check_formula(building_type, building_type[:population])
  
  building_type[:capacity].each do |v|
    check_formula(building_type, v[:formula])
  end unless building_type[:capacity].nil?
  
  building_type[:abilities][:speedup_queue].each do |v|
    check_formula(building_type, v[:speedup_formula])
  end unless building_type[:abilities][:speedup_queue].nil?
  
  check_formula(building_type, building_type[:abilities][:defense_bonus])
  check_formula(building_type, building_type[:abilities][:unlock_building_slots])
  check_formula(building_type, building_type[:abilities][:garrison_size_bonus])
  check_formula(building_type, building_type[:abilities][:army_size_bonus])
end
