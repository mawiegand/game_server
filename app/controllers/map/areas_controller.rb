class Map::AreasController < ApplicationController
  
  def show

    raise BadRequestError if params[:x].blank? || params[:y].blank? || params[:width].blank? || params[:height].blank? || params[:level].blank?
    
    x =      Integer(params[:x])
    y =      Integer(params[:y])
    width =  Integer(params[:width])
    height = Integer(params[:height])
    level =  Integer(params[:level])
    
    @map_subtree = Map::Node.root.subtree_for_area(x,y,width,height,level)
    @max_levels = level # maximum level for use during rendering
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @map_subtree.to_json() }
    end
  end
  
end
