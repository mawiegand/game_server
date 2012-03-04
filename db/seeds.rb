# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


root = Map::Node.create_root_node
root.min_x = -8.0
root.min_y = -8.0
root.max_x = 8.0
root.max_y = 8.0
root.save
root.create_children
root.children[0].create_children