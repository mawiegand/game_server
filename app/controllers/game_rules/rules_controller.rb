class GameRules::RulesController < ApplicationController
  layout 'action'
  
  def show
    @only = []

    @only.push(:version) if params.key? :version
    @only.push(:unit_types) if params.key? :units
    @only.push(:science_types) if params.key? :sciences
    @only.push(:building_types) if params.key? :buildings
    @only.push(:resource_types) if params.key? :resources      

    @rules = GameRules::Rules.the_rules
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @rules.to_json( @only.length > 0 ? {:only => @only } : {} )}
    end    
  end
end
