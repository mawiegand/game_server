module Mapping
  
  class GlobalMercator
    
    # transforms a xyz coordinate in TMS format (origin in lower left 
    # corner) to google's XYZ format (origin in upper left corner).
    def self.tms_to_google_tile_code(tx, ty, zoom)
      return { x: tx, y: ((1 << zoom) - ty -1), zoom: zoom }
    end
    
    # transforms a xyz coordinate in google's format to TMS format 
    def self.google_to_tms_tile_code(tx, ty, zoom) 
      return { x: tx, y: ((1 << zoom) - ty -1), zoom: zoom };
    end
    
    # transforms a xyz TMS coordinate to microsofts quad tree code.
    def self.tms_to_quad_tree_tile_code(tx, ty, zoom)
      path = ""
      ty = (1<<zoom)-ty-1
      
      zoom.downto(1) do |i|
        digit = 0
        mask = 1 << (i-1)
        if (tx & mask) != 0
          digit+= 1;
        end
        if (ty & mask) != 0 
          digit+= 2;
        end
        path = "#{path}#{digit}"
      end
      
      return path
    end
    
    # transforms a quad tree path to an xyz coordinate in TMS format. 
    def self.quad_tree_to_tms_tile_code(path)
      zoom = path.length
      tx = 0
      ty = 0
		  
		  zoom.downto(1) do |i|
		    digit = Integer(path[zoom-i])
			  mask = 1 << (i-1)
			  if (digit & 1) != 0 
				  tx += mask
			  end
			  if (digit & 2) != 0 
				  ty += mask
			  end
      end
		  
		  ty = (1 << zoom) - 1 - ty
		  return { x: tx, y: ty, zoom: zoom }
    end
    
  end
  
end