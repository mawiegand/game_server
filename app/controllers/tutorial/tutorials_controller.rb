require 'util/formula.rb'

# Controller to display and download (clients) the present game rules. The 
# are automatically generated form the human-readable rules.xml file.
# It's possible to download the rules as a whole or to ask the controller
# for individual types of entities by appending [ units, sciences, ... ]
# to the url. It's also possible to just ask for the version of the rules.
class Tutorial::TutorialsController < ApplicationController
  layout 'tutorial'
  
  before_filter :authenticate
  
  def show
    @tutorial = Tutorial::Tutorial.the_tutorial
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tutorial.to_json}
    end    
  end
end
