class Ranking::CharacterRankingsController < ApplicationController
  layout "ranking"
  
  # GET /ranking/character_rankings
  # GET /ranking/character_rankings.json
  def index
    if current_character
      @marked_character = current_character
    elsif !params[:mark].blank?
      char = Fundamental::Character.find_by_id(params[:mark])
      @marked_character = char   unless char.nil?
    end
    
    per_page = 10
    
    sort = "overall_score"
    sort = "overall_score"  if params[:sort] == 'overall'
    sort = "resource_score" if params[:sort] == 'resource'
    sort = "likes"          if params[:sort] == 'likes'
    sort = "victories"      if params[:sort] == 'victories'
    sort = "victory_ratio"  if params[:sort] == 'victory_ratio'
    sort = "max_experience" if params[:sort] == 'experience'
    sort = "kills"          if params[:sort] == 'kills'

    if params[:page].blank? && @marked_character
      num_before = Ranking::CharacterRanking.where(['? > ?', sort, @marked_character.ranking[sort.to_sym]]).count
      @on_page = num_before / per_page
    end

    @ranking_character_rankings = Ranking::CharacterRanking.paginate(:page => params[:page] || @on_page, 
                                                                     :per_page => per_page, 
                                                                     :order => "#{sort} DESC")
    @title = "Player Ranking"

    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: @ranking_character_rankings }
    end
  end
end
