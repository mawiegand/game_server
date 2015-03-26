#!/usr/bin/env ruby
#
# Script for placing npc armies and artifacts
#

@report = {
    :started_at => Time.now
}

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))
require 'util/formula'


Rails.logger.info "NPC PLACEMENT: Start creating NPC armies..."

region_factor     = 0.25   # at least num_regions * region_factor npc armies
max_region_factor = 1.00   # controls the number of npcs in the case where there are more armies than regions*region_factor

num_armies        = Military::Army.non_npc.non_garrison.count
avg_size_armies   = Military::Army.non_npc.non_garrison.average(:size_present)  || 1.0
max_size_armies   = Military::Army.non_npc.non_garrison.maximum(:size_present)  || 1

round_age         = Fundamental::RoundInfo.the_round_info.age || 1
num_npcs          = Military::Army.npc.non_garrison.at_least_units(round_age).count
avg_size_npcs     = Military::Army.npc.non_garrison.at_least_units(round_age).average(:size_present)  || 0.0

num_characters    = Fundamental::Character.count || 1
num_regions       = Map::Region.count || 1

Rails.logger.info "NPC PLACEMENT: #{num_armies} armies, with an average size of #{avg_size_armies || "0"}."
Rails.logger.info "NPC PLACEMENT: #{num_npcs} npc armies, with an average size of #{avg_size_npcs || "0"}."

count_npc_placed = 0
max_npc_placed   = nil
min_npc_placed   = nil

# logic for desired number: if not nr*nf armies, place up to nr*nf armies, 
# but not more than twice as much as there are characters. If there are
# more than nr*nf armies, place as many npcs, but not more than there
# are regions (in average: one per region).
desired_number_of_npcs = if num_armies < (num_regions * region_factor).ceil
  [num_characters * 4, (num_regions * region_factor).ceil].min
else
  [num_armies, (num_regions * max_region_factor)].min
end

total_size = num_npcs * avg_size_npcs  
while num_npcs < desired_number_of_npcs

  if avg_size_npcs < avg_size_armies
    size = Random.rand(avg_size_armies.floor..max_size_armies.ceil)
  else
    size = Random.rand(1..avg_size_armies.ceil)    
  end
  
  location = nil
  
  if Random.rand(0..1.0) < 0.2
    location = Map::Location.find_empty_in_inhabited
  end
  location = Map::Location.find_empty                                 if location.nil?
  raise InternalServerError.new('Could not claim an empty location.') if location.nil?
  
  Military::Army.create_npc(location, size)
  
  max_npc_placed = [(max_npc_placed || 0),       size].max
  min_npc_placed = [(min_npc_placed || 9999999), size].min
  count_npc_placed += 1
  
  Rails.logger.info "NPC PLACEMENT: Creating a npc army with #{size} units."
  total_size += size
  num_npcs += 1
  avg_size_npcs = total_size / num_npcs
end

Rails.logger.info "NPC PLACEMENT: Placed #{count_npc_placed || "0" } npc armies, smallest with #{ min_npc_placed || "0" } units, largest with #{ max_npc_placed || "0" }."


Rails.logger.info "NPC PLACEMENT: Start creating artifacts..."

artifact_count = 0

artifact_types = GameRules::Rules.the_rules.artifact_types
artifact_types.each do |artifact_type|

  # determine existing artifact count
  existing_artifacts = Fundamental::Artifact.where(type_id: artifact_type[:id]).count

  # determine calculated artifact count
  formula = Util::Formula.parse_from_formula(artifact_type[:amount], 'DAYS')
  calculated_artifacts = formula.apply(Fundamental::RoundInfo.the_round_info.age)

  # determine artifact count to create
  new_artifacts = calculated_artifacts > existing_artifacts ? calculated_artifacts - existing_artifacts : 0

  # create missing artifacts with npc army at same location
  (0...new_artifacts).each do
    location = Map::Location.find_empty_without_army
    unless location.nil?
      Fundamental::Artifact.create_at_location_with_type(location, artifact_type[:id], 2*avg_size_armies, 2 * max_size_armies)
      artifact_count += 1
    end
  end
end

current_artifacts = Fundamental::Artifact.count



if count_npc_placed > 0 || artifact_count > 0
  Rails.logger.info "NPC PLACEMENT: Compile and email report."

  @report[:finished_at]       = Time.now
  @report[:num_npcs_placed]   = count_npc_placed
  @report[:min_size]          = min_npc_placed || 0
  @report[:max_size]          = max_npc_placed || 0
  @report[:num_npcs]          = num_npcs
  @report[:average_size]      = avg_size_npcs
  @report[:num_artifacts]     = artifact_count
  @report[:current_artifacts] = current_artifacts

  Backend::NpcMailer.npc_placement_report(@report).deliver
end

Rails.logger.info "NPC PLACEMENT: Finished all tasks."
