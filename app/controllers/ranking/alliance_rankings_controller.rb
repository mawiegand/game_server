class Ranking::AllianceRankingsController < ApplicationController
  layout "ranking"
  
  # GET /ranking/alliance_rankings
  # GET /ranking/alliance_rankings.json
  def index
    sort = "num_fortress"
    sort = "num_fortress"   if params[:sort] == 'fortress'
    sort = "overall_score"  if params[:sort] == 'overall'
    sort = "resource_score" if params[:sort] == 'resource'
    sort = "num_members"    if params[:sort] == 'members'
    sort = "kills"          if params[:sort] == 'kills'

    @ranking_alliance_rankings = Ranking::AllianceRanking.find(:all, :order => "#{sort} DESC")
    @title = "Alliance Ranking"

    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: @ranking_alliance_rankings }
    end
  end  
end
