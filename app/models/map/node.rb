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

  # ###################################################################################################
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
  # ###################################################################################################
  
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
    
    # returns the subtree starting at this node. Expands the tree to a maximum of
    # num_levels levels. Should be used with care: extremely database heavy, 
    # due to branching factor of 4 do not querry more than 5 or 6 levels at max
    # (will already take several hundreds of ms to process).
    #
    # With the optional timestamp-argument it's possible to restrict expansion of
    # nodes to those parts of the subtree, that have changed recently (after the
    # given timestamp). If this argument is not specified, the whole requested
    # subtree will be expanded.
    def subtree(num_levels, modified_since_timestamp = nil)
      if (num_levels > 0 && !self.leaf? &&                 
          (!modified_since_timestamp || self.updated_at > modified_since_timestamp))
        self[:c0] = self.children[0].subtree num_levels-1, modified_since_timestamp
        self[:c1] = self.children[1].subtree num_levels-1, modified_since_timestamp
        self[:c2] = self.children[2].subtree num_levels-1, modified_since_timestamp
        self[:c3] = self.children[3].subtree num_levels-1, modified_since_timestamp
      end
      return self
    end
    
    # expands the ancestors of the given node (or subtree) and returns a subtree 
    # with a complete 'path' from the root node to this particular node.
    def expand_ancestors
      if self.parent
        c = self.path[path.length-1]  # 'address' of this node; which child is it?
        self.parent[:c0] = self if c == '0'
        self.parent[:c1] = self if c == '1'
        self.parent[:c2] = self if c == '2'
        self.parent[:c3] = self if c == '3'

        return self.parent.expand_ancestors
      else
        return self
      end
    end
      
  
  # ###################################################################################################  
  #
  # end of act_as_quadtree
  #
  # ###################################################################################################
  
  
  # Please put any game-server implementation-specific code below this line!
  
  
  
  # Finder method for various options of how to address individual nodes.
  # Nodes can be addressed using one of the following three methods:
  # 1. by string 'root' - this addresses the root node (no parent_id, level 0)
  # 2. by id - this uses the unique primary key, the automatically-assigned 
  #    auto_increment during node-creation
  # 3. by Microsoft's quad-tree path - qt0101 addresses he upper-left, upper-right,
  #    upper-left, upper-right child of the root node. Remember to always put the
  #    prefix 'qt' in front of the address in order to use this scheme.
  # Does not throw an exception but returns nil if nothing is found.
  def self.find_by_address(address)
    if (address == 'root')                           # root node
      @map_node = Map::Node.root
    elsif !address.blank? and address[0..1] == 'qt'  # microsoft quad-tree path
      @map_node = Map::Node.find_by_path(address[2..(address.length)])
    else                                             # access by id (primary key)
      @map_node = Map::Node.find_by_id(address)
    end
  end
  
end
