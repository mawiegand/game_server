# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


root = Map::Node.create_root_node
root.min_x = -20037508.342789244
root.min_y = -20037508.342789244
root.max_x = 20037508.342789244
root.max_y = 20037508.342789244

nodes = [ root ]

while !nodes.empty?
  
  node = nodes.pop
  
  if node.max_x - node.min_x > 1000.0 * 1000.0   # 1000 km
    node.create_children
    node.children.each { |n| nodes.insert 0, n }
  end
  
end