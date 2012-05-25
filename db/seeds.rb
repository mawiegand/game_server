require 'mapping/global_mercator'

# This file seeds the database after its creation (or a reset)
# Everything a "blank" game needs to be ready to be started should go in here.

user = Backend::User.new()
user.login = 'admin'
user.email = 'info@5dlab.com'
user.password = '5dlab5dlab'
user.admin = true
user.staff = true
user.deleted = false
user.save

# DUMMY DATA FOR TESTING

alliance_data=[ { id: 0,
              members: [ 14, 15, 16, 17 ] },    # players without alliance
            { id: 1,
              tag: 'DW', 
              name: 'DireWolves', 
              members: [ 1, 2, 3, 4, 5 ] },
            { id: 2,
              tag: 'Yetis', 
              name: 'Nackte Yetis', 
              members: [ 6, 7, 8 ]  }, 
            { id: 3,
              tag: 'NORD', 
              name: 'Die Nordmaenner', 
              members: [ 9, 10, 11, 12, 13 ] }  
          ];
          
character_data=[ {}, 
             { id: 1, name: 'Egbert', identifier: 'eOmKvNkXSRLmbTDQ' },
             { id: 2, name: 'Paffi' },
             { id: 3, name: 'David' },
             { id: 4, name: 'Enzio' },
             { id: 5, name: 'Kurt Kugel' },
             { id: 6, name: 'Bonzo' },
             { id: 7, name: 'Haumi' },
             { id: 8, name: 'Haubi' },
             { id: 9, name: 'Hubert K.' },
             { id: 10, name: 'Peter Schmidt' },
             { id: 11, name: 'Dicker' },
             { id: 12, name: 'Gandalf' },
             { id: 13, name: 'Grubtsch' },
             { id: 14, name: 'Noob' },
             { id: 15, name: 'Newby' },
             { id: 16, name: 'OberNoob' },
             { id: 17, name: 'Neuling' },
          ];
          
alliance_data.each do |ally|
  if ally[:id] == 0
    ally[:members].each do |member|
      Fundamental::Character.create( name: character_data[member][:name] )
    end
  else 
    alliance = Fundamental::Alliance.create( tag: ally[:tag], name: ally[:name] )
    ally[:members].each do |member| 
      character =  alliance.members.build( name: character_data[member][:name] )
      character.alliance_tag = alliance.tag
      character.identifier = character_data[member][:identifier] unless character_data[member][:identifier].blank?
      character.save
    end
    alliance.save
  end
end

alliances = Fundamental::Alliance.all
characters = Fundamental::Character.all


# ############################################################################
# 
#   Seed the map
#
#   Seeds a world-map with 500 x 500 km tiles. Ranges (min|max  x|y) are 
#   specified in meters (compatible with mapping services).
#
# ############################################################################

# create the top-level root node that spans the whole world


root = Map::Node.create_root_node     

root.min_x = -20037508.342789244
root.min_y = -20037508.342789244
root.max_x = 20037508.342789244
root.max_y = 20037508.342789244

nodes = [ root ]

# now expand the node(s) until level 5

while !nodes.empty?
  
  node = nodes.pop
  
  if node && node.level < 4
    node.create_children
    node.children.each { |n| nodes.insert 0, n }
  end
  
end


# starting from level 5 only expand some nodes (less with each additional level).

def check_neighbour(tms, level)
  path = Mapping::GlobalMercator.tms_to_quad_tree_tile_code(tms[:x], tms[:y], tms[:zoom])
  node = Map::Node.find_by_path(path)
  if node.blank?
    node = Map::Node.find_by_path(path[0, path.length-1])
  end
  if node.blank?
    puts "ERROR: did not find a node for #{ path } and #{ path[0, path.length-1] }."
    return []
  elsif node.level < level
    if !node.leaf
      puts "ERROR: this node was expected to be a leaf node!"
      return []
    end
    return [ node ]
  else
    return []
  end
end

def check_split_neighbours node
  nodes = []
  tms = Mapping::GlobalMercator.quad_tree_to_tms_tile_code(node.path)
  if tms[:x] > 0 
    nodes += check_neighbour({ x: tms[:x]-1, y: tms[:y], zoom:tms[:zoom] }, node.level);
  end
  if tms[:y] > 0 
    nodes += check_neighbour({ x: tms[:x], y: tms[:y]-1, zoom:tms[:zoom] }, node.level); 
  end
  if tms[:y] < 4**node.level-1
    nodes += check_neighbour({ x: tms[:x], y: tms[:y]+1, zoom:tms[:zoom] }, node.level); 
  end
  if tms[:x] < 4**node.level-1
    nodes += check_neighbour({ x: tms[:x]+1, y: tms[:y], zoom:tms[:zoom] }, node.level);
  end
  return nodes
end

def split_all_nodes(nodes, randmax=1, randtrue=1)
    while !nodes.empty?
    node = nodes.pop
    node.reload
    if node.leaf && rand(randmax) < randtrue     # only split nodes that haven't been split before  #-3
      node.create_children
      split_nodes = check_split_neighbours(node) # need to check neighbours: don't wanna create too large level-jumps
      if split_nodes && split_nodes.length > 0
        split_all_nodes(split_nodes)             #  have to split all neighbouring nodes (with probability 1)
      end
    end
  end
end

for i in (4..4)
  nodes = Map::Node.find_all_by_level i
  
  puts "INFO: working on level #{i}."
  
  split_all_nodes(nodes, i-1, 1)     # i-3 (when starting with level 5)
end

# create regions and locations

puts "INFO: creating regions and locations."

nodes = Map::Node.find_all_by_leaf true

while !nodes.empty?
  node = nodes.pop
  region = node.build_region
  region.save
  
  for pos in 0..8
    location = region.locations.build
    location.slot = pos

    if (pos == 0)  # slot 0: fortress
      location.type_id = 1 # 1: fortress
      location.create_settlement({
        :type_id    => location.type_id,
        :region_id  => location.region_id,
        :node_id    => node.id,
        :founded_at => DateTime.now,
        :owns_region=> true,
      })
      location.settlement.create_building_slots_according_to(GameRules::Rules.the_rules.settlement_types[location.type_id][:building_slots])
      location.right_of_way = rand(4)
    else
      if (rand(4) < 2)
        location.type_id = 0 # 0: empty 
      else
        location.type_id = rand(2)+2  # 2: settlement, 3: outpost
      end
      location.right_of_way = 0
    end
    location.level = rand(10) if location.type_id > 0
    
    if (rand(10) < 1) 
      location.count_markers = 1
    end
          
    if location.type_id > 0
      char = characters[rand(characters.length)] # choose member
      ally = char.alliance                       # choose ally
      
      if location.type_id == 1
        location.settlement.owner_id    = char[:id]
        location.settlement.alliance_id = ally[:id] unless ally.blank?
        location.settlement.founder_id  = char[:id]
        location.settlement.save
      else
        location.owner_id = char[:id]
        location.owner_name = char[:name]
        location.alliance_id = ally[:id]   unless ally.blank?
        location.alliance_tag = ally[:tag] unless ally.blank?
        location.save
      end
    end
    
    if (pos == 0)
      region.fortress_id = location.id
    end
  end
    
  region.fortress_level = region.locations[0].level
  
  region.terrain_id = rand(4)
  
  region.save
end

puts "INFO: creating armies."


locations = Map::Location.all

while !locations.empty?
  
  location = locations.pop
  
  if (location.type_id == 0 && rand(4) < 1) || (location.type_id != 0 && rand(4) < 3)
  
    for i in (0..(rand(3)))
  
      army = location.armies.build
      army.region = location.region
  
      army.name = 'Rotte'
  
      char = characters[rand(characters.length)] # choose member
      ally = char.alliance                       # choose ally
      army.owner_id = char[:id]
      army.owner_name = char[:name]
      army.alliance_id = ally[:id] unless ally.blank?
      army.alliance_tag = ally[:tag] unless ally.blank?

      army.ap_max = 4
      army.ap_present = rand(army.ap_max+1)
      army.ap_seconds_per_point = 3600*6

      army.mode = 0
      army.kills = 0
      army.victories = 0
      
      army.stance = rand(3)
      army.size_max = 1200
      army.exp = rand(1000000)
      army.rank = army.exp / 10000
      army.garrison = false
      army.save
  
      details = army.build_details
      
      GameRules::Rules.the_rules.unit_types.each do |unit_type| 
        details[unit_type[:db_field]] = rand(100)
      end
      
      details.save
    end
  end
  
  if (location.type_id != 0)
      army = location.armies.build
      army.region = location.region
  
      army.name = 'Garnison'
  
      char = location.owner                      # choose member
      ally = char.alliance                       # choose ally
      army.owner_id = char[:id]
      army.owner_name = char[:name]
      army.alliance_id = ally[:id] unless ally.blank?
      army.alliance_tag = ally[:tag] unless ally.blank?
      
      army.home_settlement_id = location.id
      army.home_settlement_name = "Name"

      army.ap_max = 4
      army.ap_present = rand(army.ap_max+1)
      army.ap_seconds_per_point = 3600*6

      army.mode = 0
      army.kills = 0
      army.victories = 0

      army.stance = rand(3)
      army.size_max = 1200
      army.exp = rand(1000000)
      army.rank = army.exp / 10000
      army.garrison = true
      army.save
      
      details = army.build_details
      
      GameRules::Rules.the_rules.unit_types.each do |unit_type| 
        details[unit_type[:db_field]] = rand(100)
      end
      
      details.save
  end
  
end

puts "INFO: recalculating aggregated values."

Map::Node.root.recount_settlements true # recursively update number of settlements for whole map

# ############################################################################
#
#   end of map seeding
#
# ############################################################################
