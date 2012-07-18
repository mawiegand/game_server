class Ranking::CharacterRankingsController < ApplicationController
  layout "ranking"
  
  # GET /ranking/character_rankings
  # GET /ranking/character_rankings.json
  def index
    sort = "overall_score"
    sort = "overall_score"  if params[:sort] == 'overall'
    sort = "resource_score" if params[:sort] == 'resource'
    sort = "max_experience" if params[:sort] == 'experience'

    @ranking_character_rankings = Ranking::CharacterRanking.find(:all, :order => "#{sort} DESC")
    @title = "Player Ranking"

    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: @ranking_character_rankings }
    end
  end
end
