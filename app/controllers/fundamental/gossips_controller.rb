class Fundamental::GossipsController < ApplicationController
  layout 'fundamental'
  
  def show
    @fundamental_gossip = Fundamental::Gossip.find_or_create
    
    last_modified = @fundamental_gossip.updated_at
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @fundamental_gossip }
      end
    end
  end
  
end
