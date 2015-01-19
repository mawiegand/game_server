#!/usr/bin/env ruby
# Create fight between armies

character_name_a = 'MarcelBP'
character_name_b = 'Marcel5D'

region_name = 'Schattennadelwald'

def create_army(character_name, region_name, army_size)
  character = Fundamental::Character.find_by_name_case_insensitive(character_name)
  abort 'Couldn\'t find character' if character.nil?

  region = Map::Region.find_by_id_or_name(region_name)
  abort 'Couldn\'t find region' if region.nil?
  location = region.locations.first

  # increase command_points of home_settlement
  settlement = character.home_location.settlement
  settlement.command_points += 1
  settlement.save

  army = Military::Army.new({name: 'New Army',
                             home_settlement_id: character.home_location.settlement.id,
                             home_settlement_name: character.home_location.settlement.name,
                             ap_max: 4,
                             ap_present: 4,
                             ap_seconds_per_point: Military::Army.regeneration_base_duration,
                             mode: Military::Army::MODE_IDLE,
                             stance: 0,
                             size_max: location.settlement.army_size_max || 1000, # 1000 is default size
                             exp: 0,
                             rank: 0,
                             ap_next: DateTime.now.advance(:seconds => Military::Army.regeneration_base_duration),
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

  details['unit_clubbers'] = army_size

  army.update_from_details

  puts 'Created army for character ' + character_name.to_s + ' in region ' + region_name.to_s if army.save
  army
end

# characters
character_a = Fundamental::Character.find_by_name_case_insensitive(character_name_a)

# First faction armies
faction_1_small_army_1 = create_army(character_name_a, region_name, 11)
faction_1_big_army_1 = create_army(character_name_a, region_name, 999)
faction_1_big_army_2 = create_army(character_name_a, region_name, 999)

# Second faction armies
#faction_2_small_army_1 = create_army(character_name_b, region_name, 10)
faction_2_big_army_1 = create_army(character_name_b, region_name, 100)
faction_2_big_army_2 = create_army(character_name_b, region_name, 100)

exp_before_fight_1 = character_a.exp
puts 'Exp before fight 1: ' + (exp_before_fight_1).to_s
# bug fight?
Military::Battle.start_fight_between(faction_1_small_army_1, faction_2_big_army_1)
battle1 = Military::Battle.start_fight_between(faction_1_big_army_1, faction_2_big_army_1)
while (battle1.battle_done?)
  puts 'Still fighting fight 1!'
  sleep(5)
end
exp_after_fight_1 = character_a.exp

puts 'Exp gained from fight 1: ' + (exp_after_fight_1 - exp_before_fight_1).to_s

exp_before_fight_2 = character_a.exp
puts 'Exp before fight 2: ' + (exp_before_fight_2).to_s
# normal fight?
battle2 = Military::Battle.start_fight_between(faction_1_big_army_2, faction_2_big_army_2)
while (battle2.battle_done?)
  puts 'Still fighting fight 2!'
  sleep(5)
end
exp_after_fight_2 = character_a.exp

puts 'Exp gained from fight 2: ' + (exp_after_fight_2 - exp_before_fight_2).to_s