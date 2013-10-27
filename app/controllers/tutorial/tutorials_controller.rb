require 'util/formula.rb'

# Controller to display and download (clients) the present game rules. The 
# are automatically generated form the human-readable rules.xml file.
# It's possible to download the rules as a whole or to ask the controller
# for individual types of entities by appending [ units, sciences, ... ]
# to the url. It's also possible to just ask for the version of the rules.
class Tutorial::TutorialsController < ApplicationController
  layout 'tutorial'

  def show
    @tutorial = Tutorial::Tutorial.the_tutorial
    
    expires_now
    
    fresh = false
    if params.key?(:build) && params.key?(:minor) && params.key?(:major)
      fresh = Gem::Version.new("#{params[:major]}.#{params[:minor]}.#{params[:build]}") >= Gem::Version.new("#{@tutorial.version[:major]}.#{@tutorial.version[:minor]}.#{@tutorial.version[:build]}")
    elsif params.key?(:minor) && params.key?(:major)
      fresh = Gem::Version.new("#{params[:major]}.#{params[:minor]}") >= Gem::Version.new("#{@tutorial.version[:major]}.#{@tutorial.version[:minor]}")
    elsif params.key?(:major)
      fresh = Gem::Version.new("#{params[:major]}") >= Gem::Version.new("#{@tutorial.version[:major]}")
    end
          
    if fresh 
      render :nothing => true, :status => '304 Not Modified'
    else
      render_not_modified_or(@tutorial.updated_at) do # check whether we really should use the updated_at-check here. perhaps not a very good idea
        respond_to do |format|
          format.html # show.html.erb
          format.json do 
            render :json => @tutorial.as_json(:root => use_restkit_api?)
          end
        end
      end
    end    
  end
end
