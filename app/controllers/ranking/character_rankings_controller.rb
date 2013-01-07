class Ranking::CharacterRankingsController < ApplicationController
  layout "ranking"
  
  before_filter :authenticate
  
  # GET /ranking/character_rankings
  # GET /ranking/character_rankings.json
  def index
    if current_character
      @marked_character = current_character
    elsif !params[:mark].blank?
      char = Fundamental::Character.find_by_id(params[:mark])
      @marked_character = char   unless char.nil?
    end
    
    per_page = params[:per_page].blank? ? 25 : params[:per_page].to_i
    
    sort = "overall_score"
    sort = "overall_score"  if params[:sort] == 'overall'
    sort = "resource_score" if params[:sort] == 'resource'
    sort = "likes"          if params[:sort] == 'likes'
    sort = "victories"      if params[:sort] == 'victories'
    sort = "victory_ratio"  if params[:sort] == 'victory_ratio'
    sort = "max_experience" if params[:sort] == 'experience'
    sort = "kills"          if params[:sort] == 'kills'

    if params[:page].blank? && @marked_character
      num_before = Ranking::CharacterRanking.where(["#{ sort } > ?", @marked_character.ranking[sort.to_sym]]).count
      page = num_before / per_page + 1
    elsif !params[:page].blank?
      page = params[:page].to_i
    else
      page = 1
    end

    @ranking_character_rankings = Ranking::CharacterRanking.paginate(:page => page, :per_page => per_page, :order => "#{sort} DESC")
    
    nr = (page - 1) * per_page + 1     
    returned_ranking_entries = []                                              
    @ranking_character_rankings.each do |ranking_entry|
      ranking_entry_hash = ranking_entry.attributes
      ranking_entry_hash[:rank] = nr
      returned_ranking_entries << ranking_entry_hash
      nr += 1
    end
                                                                   
    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: returned_ranking_entries.as_json }
    end
  end
end
