class Map::SubtreesController < ApplicationController
  
  
  # Shows whole subtrees below a given node. Does not need any authentication; the map 
  # structure is public and therefore world-readable.
  # 
  # As in /map/nodes there are two possibilities for addressing nodes:
  # 1. by their id (auto_increment assigned on node creation) or
  # 2. by their quad-tree path (e.g. nodes/qt0101 translates to the forth-level node that 
  #    is the upper-left, upper-rigth, upper-left, upper-right child of the root node.
  # 
  # The maximal depth of the transmitted subtree can be specified by a querry parameter
  # "levels=N". It's important to cut the subtree of somewhere, as otherwise the amount
  # of data quickly may become to large. If nothing is specified, levels=3 is assumed, 
  # what would transmit a maximum number of (1+4+4*4+4*4*4) = (5+16+64) = 85 
  # nodes in total. A parameter of levels=4 would already lead to up to 341 nodes.
  #
  # The action supports conditional get. Set 'if_modified_since' in the HTTP request header
  # to a RFC-compliant date (e.g. "Sun, 04 Mar 2012, 03:55:10 GMT"). This would return nothing
  # in case not a single node in the subtree has been changed after the given date or a
  # subtree with only the branches, in which there occured a change.
  #
  # The root node is a special node that can be accessed directly via "root".
  #
  #  GET /map/subtrees/1           # html representation of subtree below node with id 1
  #  GET /map/subtrees/1.json      # json representation of subtree below node with id 1
  #  GET /map/subtress/qt1         # the subtree below node at quad-tree path '1'
  #  GET /map/subtrees/qt1.json    
  #  GET /map/subtrees/root        # the subtree below root node (no parent, level 0)
  #  GET /map/subtress/root.json
  def show
  end

end
