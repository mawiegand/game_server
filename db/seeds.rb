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

NUM_FULL_LEVELS   = 3
NUM_SPARSE_LEVELS = 2


# ############################################################################
# 
#   Load Region Names
#
# ############################################################################

terrains = ['plain', 'forest', 'mountain', 'desert']

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

region_names = []

terrains.each do |terrain|
  print "loading region names for terrain #{terrain}... "  
  
  # construct filenames
  filename   = File.expand_path(File.join(File.dirname(__FILE__), "..", "rules", "region_names", "#{terrain}.txt"))
  region_names << File.open(filename).readlines
  
  puts "found #{ region_names.last.count } names to chose from." 
end


# ############################################################################
# 
#   Seed NPCs
#
# ############################################################################

@npcs = [
  Fundamental::Character.create_new_character('npc_1', 'Neandertaler', 1.0, true),
]

# ############################################################################
# 
#   Seed Global Chat Channel
#
# ############################################################################

Messaging::JabberCommand.create({
  type_id:   'muc_create',
  room:      'global',
  processed: false,
})

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
root.max_x =  20037508.342789244
root.max_y =  20037508.342789244

nodes = [ root ]

# now expand the node(s) until level 5

while !nodes.empty?
  node = nodes.pop
  if node && node.level < NUM_FULL_LEVELS
    node.create_children
    node.children.each { |n| nodes.insert 0, n }
  end
end


# starting from next level only expand some nodes (less with each additional level).

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

for i in (NUM_FULL_LEVELS..(NUM_FULL_LEVELS+NUM_SPARSE_LEVELS))
  nodes = Map::Node.find_all_by_level i
  puts "INFO: working on level #{i}."
  split_all_nodes(nodes, i-NUM_FULL_LEVELS+4, 1)     # i-3 (when starting with level 5)
end

# create regions and locations

puts "INFO: creating regions and locations."

nodes = Map::Node.find_all_by_leaf true

def create_fortress(location)
  owner = @npcs[rand(@npcs.length)] # TODO: NPCs
  Settlement::Settlement.create_settlement_at_location(location, 1, owner)   # 1: fortress
  
  details = location.settlement.garrison_army.details
  if details.has_attribute? 'unit_neanderthal'
    details.increment('unit_neanderthal', 60 + rand(60))
  end
  details.save  
end

while !nodes.empty?
  node   = nodes.pop
  region = node.create_region
  
  for pos in 0..8
    location = region.locations.build
    location.slot = pos
    location.right_of_way = 0
    location.settlement_type_id = 0 # 0: empty   
    location.save

    if (pos == 0)  # slot 0: fortress
      region.fortress_id = location.id
      create_fortress(location)
    end 
  end
  
  region.terrain_id = rand(4)
  # hack for missing terrain tiles
  if region.terrain_id != 3
    region.terrain_id = 0    # everything not a desert is a plain
  end
  
  new_name = region_names[region.terrain_id].sample.chomp
  region_names[region.terrain_id].delete(new_name)
  
  region.name = new_name
  region.fortress.name = new_name
  region.fortress.save
  region.save
end


puts "INFO: recalculating aggregated values."

Map::Node.root.recount_settlements true # recursively update number of settlements for whole map

# ############################################################################
#
#   end of map seeding
#
# ############################################################################

puts "INFO: creating shop offers."

Shop::ResourceOffer.create({
  price: 8,
  amount: 15,
  resource_id: 3,
  started_at: Time.now,
  ends_at: Time.now + 1.year 
})

Shop::ResourceOffer.create({
  price: 24,
  amount: 50,
  resource_id: 3,
  started_at: Time.now,
  ends_at: Time.now + 1.year 
})

Shop::ResourceOffer.create({
  price: 47,
  amount: 120,
  resource_id: 3,
  started_at: Time.now,
  ends_at: Time.now + 1.year 
})

Shop::BonusOffer.create({
  price: 5,
  resource_id: 0,
  duration: 168,
  bonus: 0.15, 
  started_at: Time.now,
  ends_at: Time.now + 1.year 
})

Shop::BonusOffer.create({
  price: 5,
  resource_id: 1,
  duration: 168,
  bonus: 0.15, 
  started_at: Time.now,
  ends_at: Time.now + 1.year 
})

Shop::BonusOffer.create({
  price: 5,
  resource_id: 2,
  duration: 168,
  bonus: 0.15, 
  started_at: Time.now,
  ends_at: Time.now + 1.year 
})



