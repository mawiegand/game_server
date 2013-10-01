# encoding: UTF-8

require 'mapping/global_mercator'

exit(1)  if Rails.env.production?


# This file seeds the database after its creation (or a reset)
# Everything a "blank" game needs to be ready to be started should go in here.

user = Backend::User.new()
user.login = 'admin'
user.email = 'info@5dlab.com'
user.password = '5dlab5dlab'
user.admin = true
user.staff = true
user.partner = true
user.deleted = false
user.save

NUM_FULL_LEVELS   = 2
NUM_SPARSE_LEVELS = 1

ROUND_NAME   = "Earth"
ROUND_NUMBER =  3

NPC_MIN_UNITS = 60
NPC_MAX_UNITS = 120



# ############################################################################
# 
#   Load Region Names
#
# ############################################################################

terrains     = ['plain', 'forest', 'mountain', 'desert', 'swamp']
weights      = [ 16, 16, 1, 4, 4 ]   # non-negative integers controlling the frequency of terrain types: p(x) = weight_of_x / total_sum_of_weights
lookup = []
weights.each_index { |i| weights[i].times { lookup.push i } }

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
#   Create Round Info
#
# ############################################################################

Fundamental::RoundInfo.create({
  id: 1,
  name: ROUND_NAME,
  number: ROUND_NUMBER,
  started_at: Time.now,
})

# ############################################################################
# 
#   Seed NPCs
#
# ############################################################################

@npc = [
  Fundamental::Character.create_new_character('npc_1', 'Neandertaler', 1.0, true),
]

# ############################################################################
# 
#   Seed Global Chat Channel
#
# ############################################################################

puts "add command to create clobal chat rooms."

Messaging::JabberCommand.create({
  command:   'muc_create',
  room:      'global',
  processed: false,
})

Messaging::JabberCommand.create({
  command:   'muc_create',
  room:      'help',
  processed: false,
})

Messaging::JabberCommand.create({  # german everything-on-topic
  command:   'muc_create',
  room:      'plauderhöhle',
  processed: false,
})

Messaging::JabberCommand.create({  # english everyhting-on-topic
  command:   'muc_create',
  room:      'whisperingcavern',
  processed: false,
})

Messaging::JabberCommand.create({
  command:   'muc_create',
  room:      'handel',
  processed: false,
})

Messaging::JabberCommand.create({
  command:   'muc_create',
  room:      'insider',
  processed: false,
})

Messaging::JabberCommand.create({
  command:   'muc_create',
  room:      'beginner',
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
    []
  elsif node.level < level
    unless node.leaf
      puts "ERROR: this node was expected to be a leaf node!"
      return []
    end
    [node]
  else
    []
  end
end

def check_split_neighbours(node)
  nodes = []
  tms = Mapping::GlobalMercator.quad_tree_to_tms_tile_code(node.path)
  if tms[:x] > 0 
    nodes += check_neighbour({ x: tms[:x]-1, y: tms[:y], zoom:tms[:zoom] }, node.level)
  end
  if tms[:y] > 0 
    nodes += check_neighbour({ x: tms[:x], y: tms[:y]-1, zoom:tms[:zoom] }, node.level)
  end
  if tms[:y] < 4**node.level-1
    nodes += check_neighbour({ x: tms[:x], y: tms[:y]+1, zoom:tms[:zoom] }, node.level)
  end
  if tms[:x] < 4**node.level-1
    nodes += check_neighbour({ x: tms[:x]+1, y: tms[:y], zoom:tms[:zoom] }, node.level)
  end
  nodes
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

(NUM_FULL_LEVELS..(NUM_FULL_LEVELS + NUM_SPARSE_LEVELS)).each do |i|
  nodes = Map::Node.find_all_by_level i
  puts "INFO: working on level #{i}."
  split_all_nodes(nodes, i - NUM_FULL_LEVELS + 4, 1)     # i-3 (when starting with level 5)
end

# further split germany

puts "INFO: now splitting germany"

def split_to_path(path)

  node = Map::Node.root

  while !node.leaf? && path.length > 0
    c = path[0].to_i
    node = node.children[c]
    path = path[1..-1]
  end

  while path.length > 0 && node.leaf?
    split_all_nodes([ node ])
    c = path[0].to_i
    node = node.children[c]
    path = path[1..-1]
  end
end

paths = [
    "12020133333333",
    "12020333333333",
    "12020300033333",
    "12020300133333",
    "12020300233333",
    "12020300333333",
    "12020301033333",
    "12020301133333",
    "12020301233333",
    "12020301333333",
    "12020302033333",
    "12020302133333",
    "12020302233333",
    "12020302333333",
    "12020303033333",
    "12020303133333",
    "12020303233333",
    "12020303333333",
    "12022300333333",
    "12022101333333",
    "12022102333333",
    "12022103333333",
    "12022110333333",
    "12022111333333",
    "12022112333333",
    "12022113333333",
    "12022120333333",
    "12022121333333",
    "12022122333333",
    "12022123333333",
    "12022130333333",
    "12022131333333",
    "12022132333333",
    "12022133333333",
    "120221013203333",
    "120221013213333",
    "120221013223333",
    "120221013233333"
]

paths.each do |path|
  split_to_path(path)
end



puts "Created #{ Map::Node.where(leaf: true).count} leaf nodes."

# create regions and locations

puts "INFO: creating regions and locations."

nodes = Map::Node.find_all_by_leaf true

def create_fortress(location)
  owner = @npc[rand(@npc.length)] # TODO: NPCs
  Settlement::Settlement.create_settlement_at_location(location, 1, owner)   # 1: fortress
  
  details = location.settlement.garrison_army.details
  if details.has_attribute? 'unit_neanderthal'
    details.increment('unit_neanderthal', NPC_MIN_UNITS + rand(NPC_MAX_UNITS - NPC_MIN_UNITS))
  end
  details.save  
end

puts "INFO: using terrain type id sample list: #{ lookup.inspect }."

while !nodes.empty?
  node   = nodes.pop
  region = node.create_region

  (0..8).each do |pos|
    location                    = region.locations.build
    location.slot               = pos
    location.right_of_way       = 0
    location.settlement_type_id = 0 # 0: empty
    location.save

    if pos == 0 # slot 0: fortress
      region.fortress_id = location.id
      create_fortress(location)
    end
  end

  region.terrain_id = lookup.sample

  new_name = region_names[region.terrain_id].sample
  region_names[region.terrain_id].delete(new_name)

  region.name = new_name.chomp
  region.fortress.name = new_name.chomp
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

# die folgenden drei bonus offers werden aus dem starterpaket referenziert, daher haben sie feste ids!

Shop::BonusOffer.create({
  id: 1,
  price: 5,
  resource_id: 0,
  currency: Shop::Transaction::CURRENCY_CREDITS,
  duration: 148,
  bonus: 0.15,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})

Shop::BonusOffer.create({
  id: 2,
  price: 5,
  resource_id: 1,
  currency: Shop::Transaction::CURRENCY_CREDITS,
  duration: 148,
  bonus: 0.15,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})

Shop::BonusOffer.create({
  id: 3,
  price: 5,
  resource_id: 2,
  currency: Shop::Transaction::CURRENCY_CREDITS,
  duration: 148,
  bonus: 0.15,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})



Shop::BonusOffer.create({
  price: 5,
  resource_id: 0,
  currency: Shop::Transaction::CURRENCY_GOLDEN_FROGS,
  duration: 148,
  bonus: 0.05,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})

Shop::BonusOffer.create({
  price: 5,
  resource_id: 1,
  currency: Shop::Transaction::CURRENCY_GOLDEN_FROGS,
  duration: 148,
  bonus: 0.05,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})

Shop::BonusOffer.create({
  price: 5,
  resource_id: 2,
  currency: Shop::Transaction::CURRENCY_GOLDEN_FROGS,
  duration: 148,
  bonus: 0.05,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})

Shop::BonusOffer.create({
  price: 25,
  resource_id: 0,
  currency: Shop::Transaction::CURRENCY_CREDITS,
  duration: 148,
  bonus: 0.25,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})

Shop::BonusOffer.create({
  price: 25,
  resource_id: 1,
  currency: Shop::Transaction::CURRENCY_CREDITS,
  duration: 148,
  bonus: 0.25,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})

Shop::BonusOffer.create({
  price: 25,
  resource_id: 2,
  currency: Shop::Transaction::CURRENCY_CREDITS,
  duration: 148,
  bonus: 0.25,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})

Shop::PlatinumOffer.create({
  title: 'Platinum Account',
  price: 10,
  duration: 168,
  started_at: Time.now,
  ends_at: Time.now + 1.year
})

Shop::SpecialOffer.create({
  external_offer_id: 761,  # defined by offer in bytro shop
  title: 'Special Offer',
  price: 25,
  startet_at: Time.now,
  ends_at: Time.now + 1.year
})
