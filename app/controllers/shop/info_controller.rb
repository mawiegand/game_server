class Shop::InfoController < ApplicationController
  layout "extern"

  def show
    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: {} }
    end
  end  
end
