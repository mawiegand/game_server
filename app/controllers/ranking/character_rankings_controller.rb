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
    
    per_page = params[:per_page].blank? ? 25 : params[:per_page].to_i
    
    sort = "overall_score"
    sort = "overall_score"  if params[:sort] == 'overall'
    sort = "resource_score" if params[:sort] == 'resource'
    sort = "likes"          if params[:sort] == 'likes'
    sort = "victories"      if params[:sort] == 'victories'
    sort = "max_experience" if params[:sort] == 'experience'
    sort = "kills"          if params[:sort] == 'kills'

    if params[:page].blank? && @marked_character
      num_before = Ranking::CharacterRanking.where(
        "#{ sort } > ? or (#{ sort } = ? and id < ?)",
        @marked_character.ranking[sort.to_sym],
        @marked_character.ranking[sort.to_sym],
        @marked_character.id,
      ).count
      page = num_before / per_page + 1
    elsif !params[:page].blank?
      page = params[:page].to_i
    else
      page = 1
    end

    @ranking_character_rankings = if !params[:page].blank? || !params[:per_page].blank?
      Ranking::CharacterRanking.paginate(:page => page, :per_page => per_page, :order => "#{sort} DESC, id ASC")
    else
      Ranking::CharacterRanking.paginate(:page => 1, :per_page => Ranking::CharacterRanking.count, :order => "overall_score DESC, id ASC")
    end
    
    nr = (page - 1) * per_page + 1
    returned_ranking_entries = @ranking_character_rankings.map do |ranking_entry|
      ranking_entry_hash = ranking_entry.attributes
      ranking_entry_hash[:rank] = nr
      ranking_entry_hash[:artifact_id]   = ranking_entry.character.artifact.id unless ranking_entry.character.artifact.nil?
      ranking_entry_hash[:artifact_name] = ranking_entry.character.artifact.artifact_type[:name][:de_DE] unless ranking_entry.character.artifact.nil?
      nr += 1
      ranking_entry_hash
    end

    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: include_root(returned_ranking_entries, :character_ranking) }
    end
  end
end
