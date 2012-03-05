# This model realizes a quad-tree (of nodes and leafs) for representing maps using the common
# tiling. Internally, tiles are encoded using the Microsoft - quad-tree path, but the
# implementation
# should also provide conversions to Google (XYZ) / OSM tile-naming schemes (TMS) on both sides, the server
# back-end (in here, or in the lib) and the client-frontend (using a JavaScript implementation
# of the naming-scheme conversions).
#
# Surface coordinates in here are in X-Y coordinates, units are meters! The implementation 
# should provide means for converting these coordinates to longitude / latitude on both sides,
# within the server and within the client. TODO: look-up the projection internals.
class Map::Node < ActiveRecord::Base

  #
  # act_as_quadtree
  #
  # The following code is an adaption of "act_as_tree" from David Heinemeir Hansson for quad-trees.
  # Later, it should go into a (possibly public) plugin "act_as_quadtree" or "act_as_maptree".
  #
  # ATTENTION: please put only code in this part of the source file that belongs to the 
  #            "act_as_quadtree" facilities. Any code, that's implementation (game-server) specific
  #            should go below this block (look for "end_as_quadtree"). Thanks, Sascha.
  #
  
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
  
  # returns the first root found in the database (level = 0)
  def self.root
    self.roots.first
  end
  
  # returns all root nodes in the database (level = 0)
  def self.roots
    Map::Node.where("parent_id IS NULL AND level = 0")
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
  
  #
  # end of act_as_quadtree
  #
  
  # Please put any implementation specific code below this line!
  
  
end
