#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))
require 'util/formula'

def check_formula(type, formula, var_name = 'LEVEL')
  return if formula.nil?
  f = Util::Formula.parse_from_formula(formula, var_name)
  begin
    f.apply(1).to_s
  rescue
    puts "Error in #{type[:symbolic_id]} formula:"
    puts formula
    exit(1)
  end
end

rules = GameRules::Rules.the_rules

puts "Checking Rules Formula"
  
rules.building_types.each do |building_type|
  
  puts "Checking Building Type #{building_type[:name][:de_DE]}"
  
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

rules.artifact_types.each do |artifact_type|
  
  puts "Checking Artifact Type #{artifact_type[:name][:de_DE]}"
  
  check_formula(artifact_type, artifact_type[:amount], 'DAYS')
  check_formula(artifact_type, artifact_type[:initiation_time])
  artifact_type[:initiation_costs].each do |k, v|
    check_formula(artifact_type, v, 'LEVEL')
  end

  check_formula(artifact_type, artifact_type[:experience_production], 'MRANK')

  check_formula(artifact_type, artifact_type[:amount], 'DAYS')
end

rules.victory_types.each do |victory_type|
  
  puts "Checking Victory Type #{victory_type[:name][:de_DE]}"
  
  if !victory_type[:condition].nil? && !victory_type[:condition][:required_regions_ratio].nil?
    check_formula(victory_type, victory_type[:condition][:required_regions_ratio], 'DAYS')
  end
end

puts "Rules Formula Ok"
