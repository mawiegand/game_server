require 'mapping/global_mercator'

# This file seeds the database after its creation (or a reset)
# Everything a "blank" game needs to be ready to be started should go in here.


# DUMMY DATA FOR TESTING

alliances=[ { id: 0,
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
          
characters=[ {}, 
             { id: 1, name: 'Egbert' },
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

for i in (4..9)
  nodes = Map::Node.find_all_by_level i
  
  puts "INFO: working on level #{i}."
  
  split_all_nodes(nodes, i-1, 1)     # i-3 (when starting with level 5)
end

# create regions and locations

nodes = Map::Node.find_all_by_leaf true

while !nodes.empty?
  node = nodes.pop
  region = node.build_region
  
  for pos in 0..8
    location = region.locations.build
    location.slot = pos

    if (pos == 0)  # slot 0: fortress
      location.type_id = 1 # 1: fortress
    else
      if (rand(4) < 2)
        location.type_id = 0 # 0: empty 
      else
        location.type_id = rand(2)+2  # 2: settlement, 3: outpost
      end
    end
    location.level = rand(10) if location.type_id > 0
    
    if (rand(10) < 1) 
      location.count_markers = 1
    end
    
    if location.type_id > 0
      ally = alliances[rand(alliances.length)]  # choose ally
      char = characters[ally[:members][rand(ally[:members].length)]] # choose member
      location.owner_id = char[:id]
      location.owner_name = char[:name]
      location.alliance_id = ally[:id] unless ally[:id] == 0
      location.alliance_tag = ally[:tag] unless ally[:id] == 0
    end
    
    location.save
  end
  
  region.owner_id = region.locations[0].owner_id
  region.owner_name = region.locations[0].owner_name
  region.alliance_id = region.locations[0].alliance_id
  region.alliance_tag = region.locations[0].alliance_tag
  
  region.fortress_level = region.locations[0].level
  
  region.terrain_id = rand(4)
  
  region.save
end

Map::Node.root.recount_settlements true # recursively update number of settlements for whole map

# ############################################################################
#
#   end of map seeding
#
# ############################################################################
