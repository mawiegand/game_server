#!/usr/bin/env ruby
# Create armies at entered region

puts 'Create and place new armies'

# Get character
puts 'Enter Character Name'
character_name = gets.chomp.to_s
character = Fundamental::Character.find_by_name_case_insensitive(character_name)
abort 'Couldn\'t find character' if character.nil?

# Get target region and find location
puts 'Enter region_name or region_id for placing army'
region_name = gets.chomp.to_s
region = Map::Region.find_by_id_or_name(region_name)
abort 'Couldn\'t find region' if region.nil?
location = region.locations.first

# Get count of new armies
puts 'How many armies should be placed?'
armies_count = gets.chomp.to_i
armies_count = 1 if armies_count.nil? or armies_count == 0

counter = 1
armies_count.times do
  # increase command_points of home_settlement
  settlement = character.home_location.settlement
  settlement.command_points += 1
  settlement.save
  
  army = Military::Army.new({
	  name: 'New Army',
  	home_settlement_id: character.home_location.settlement.id,
	  home_settlement_name: character.home_location.settlement.name,
  	ap_max: 4,
	  ap_present: 4,
    ap_seconds_per_point:  Military::Army.regeneration_duration,
  	mode: Military::Army::MODE_IDLE,
	  stance: 0,
  	size_max: location.settlement.army_size_max || 1000,  # 1000 is default size
	  exp: 0,
  	rank: 0,
	  ap_next: DateTime.now.advance(:seconds =>  Military::Army.regeneration_duration),
  	garrison: false,
  	kills: 0,
	  victories: 0,
  })
  
  army.location = location
  army.region = location.region
  army.owner = character
  army.owner_name = character.name
  army.alliance = character.alliance
  army.alliance_tag = character.alliance_tag
  army.alliance_color = character.alliance_color
  
  details = army.build_details()
  
  details['unit_clubbers'] = 500
  
  army.update_from_details
  
  puts "Created " + counter + " army!" if army.save
end

puts "Finished."
