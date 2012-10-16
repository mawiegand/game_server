class Shop::InfoController < ApplicationController
  layout "ranking"
  
  def show
    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: {} }
    end
  end  
end
