class Fundamental::VictoryProgressLeadersController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate

  # GET /fundamental/victory_progresses
  # GET /fundamental/victory_progresses.json
  def index
    @fundamental_victory_progress_leaders = []
    
    GameRules::Rules.the_rules.victory_types.each do |type|
      leaders = Fundamental::VictoryProgress.where(['victory_type = ?', type[:id]]).order('fulfillment_count DESC').includes(:alliance).limit(3)
      nr = 1
      leaders.each do |leader|
        leader_hash = leader.attributes
        leader_hash[:pos] = nr
        leader_hash[:alliance_name] = leader.alliance.name
        @fundamental_victory_progress_leaders << leader_hash
        nr += 1
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_victory_progress_leaders.as_json}
    end
  end
end
