require 'util/formula.rb'

# Controller to display and download (clients) the present game rules. The 
# are automatically generated form the human-readable rules.xml file.
# It's possible to download the rules as a whole or to ask the controller
# for individual types of entities by appending [ units, sciences, ... ]
# to the url. It's also possible to just ask for the version of the rules.
class GameRules::RulesController < ApplicationController
  layout 'rules'
  
  def show
    @only = []  # render views for only part of the rules

    @only.push(:version) if params.key? :version
    @only.push(:unit_types) if params.key? :units
    @only.push(:science_types)  if params.key? :sciences
    @only.push(:building_types) if params.key? :buildings
    @only.push(:resource_types) if params.key? :resources      

    @rules = GameRules::Rules.the_rules
    
    fresh = false
    if params.key?(:build) && params.key?(:minor) && params.key?(:major)
      fresh = Gem::Version.new("#{params[:major]}.#{params[:minor]}.#{params[:build]}") >= Gem::Version.new("#{@rules.version[:major]}.#{@rules.version[:minor]}.#{@rules.version[:build]}")
    elsif params.key?(:minor) && params.key?(:major)
      fresh = Gem::Version.new("#{params[:major]}.#{params[:minor]}") >= Gem::Version.new("#{@rules.version[:major]}.#{@rules.version[:minor]}")
    elsif params.key?(:major)
      fresh = Gem::Version.new("#{params[:major]}") >= Gem::Version.new("#{@rules.version[:major]}")
    end
          
    if fresh 
      render :nothing => true, :status => '304 Not Modified'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json do
          options = { root: (use_restkit_api?() || params.has_key?(:inc_root)) }
          render :json => @rules.as_json(options) 
        end
      end
    end    
  end
end
