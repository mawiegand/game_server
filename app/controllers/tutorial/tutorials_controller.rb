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
    
    render_not_modified_or(@tutorial.updated_at) do
      respond_to do |format|
        format.html # show.html.erb
        format.json do 
          render :json => @tutorial.as_json(:root => use_restkit_api?)
        end
      end
    end    
  end
end
