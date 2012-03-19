class Map::Region < ActiveRecord::Base
  
  belongs_to :node, :class_name => "Node", :foreign_key => "node_id"
  
end
