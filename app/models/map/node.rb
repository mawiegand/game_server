# This model realizes a quad-tree (of nodes and leafs).
class Map::Node < ActiveRecord::Base
  
  # association of parent-nodes with child-nodes. the parent id (foreign key) is stored in the
  # field parent_id. when a child is changed, the parent's timestamp is updated as well. the idea
  # here is to easily help find the subtrees that have been changed.
  belongs_to :parent, :class_name => "Node", :foreign_key => "parent_id", :touch => true
  has_many :children, :class_name => "Node", :foreign_key => "parent_id", :order => :path, :dependent => :destroy

  # a class method that creates the root node of the quad tree. the root node has no parent_id set
  # and is at level zero. if the quad-tree should partition a two-dimensional continous space, the
  # user should set min/max x and y on the root node right after creation. An alternative option is
  # to set appropriate default values in the schema defintion.
  def self.create_root_node
    Map::Node.create({ level: 0, path: "" })
  end
  
  # path: uses microsoft quad-tree notation
  def create_children
    self.children.create({    # node 0: upper left
      level: self.level+1, path: self.path+"0", 
      min_x: self.min_x, max_x: (self.max_x+self.min_x) / 2.0,
      min_y: self.min_y, max_y: (self.max_y+self.min_y) / 2.0
    })
    self.children.create({    # node 1: upper right
      level: self.level+1, path: self.path+"1", 
      min_x: (self.max_x+self.min_x) / 2.0, max_x: self.max_x,
      min_y: self.min_y, max_y: (self.max_y+self.min_y) / 2.0
    })
    self.children.create({    # node 2: lower left
      level: self.level+1, path: self.path+"2", 
      min_x: self.min_x, max_x: (self.max_x+self.min_x) / 2.0,
      min_y: (self.max_y+self.min_y) / 2.0, max_y: max_y
    })
    self.children.create({    # node 3: lower right
      level: self.level+1, path: self.path+"3", 
      min_x: (self.max_x+self.min_x) / 2.0, max_x: self.max_x,
      min_y: (self.max_y+self.min_y) / 2.0, max_y: self.max_y
    })

    self.leaf = false
    self.save
  end
  
end
