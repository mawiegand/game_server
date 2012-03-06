# This file seeds the database after its creation (or a reset)
# Everything a "blank" game needs to be ready to be started should go in here.

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


# now expand the node(s) until leafs have a size of 500x500 km or less

while !nodes.empty?
  
  node = nodes.pop
  
  if node.max_x - node.min_x > 1000.0 * 1000.0   # TODO: 500 km
    node.create_children
    node.children.each { |n| nodes.insert 0, n }
  end
  
end

# ############################################################################
#
#   end of map seeding
#
# ############################################################################
