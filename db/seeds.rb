require 'mapping/global_mercator'

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

# now expand the node(s) until level 5

while !nodes.empty?
  
  node = nodes.pop
  
  if node && node.level < 5
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

for i in (5..12)
  nodes = Map::Node.find_all_by_level i
  
  while !nodes.empty?
    node = nodes.pop
    node.reload
    if node.leaf && rand(i-3) < 1   # only split nodes that haven't been split before
      node.create_children
      split_nodes = check_split_neighbours(node) # need to check neighbours: don't wanna create to large level-jumps
      if split_nodes && split_nodes.length > 0
        nodes = nodes + split_nodes # afterwards nodes may be twice in array
      end
    end
  end
    
end

# ############################################################################
#
#   end of map seeding
#
# ############################################################################
