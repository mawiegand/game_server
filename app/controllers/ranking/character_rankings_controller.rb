class Ranking::CharacterRankingsController < ApplicationController
  layout "ranking"
  
  before_filter :authenticate, :only => [:self]
  
  # GET /ranking/character_rankings
  # GET /ranking/character_rankings.json
  def index
    if !params[:mark].blank?
      char = Fundamental::Character.find_by_id(params[:mark])
      @marked_character = char unless char.nil?
    elsif current_character
      @marked_character = current_character
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

    @ranking_character_rankings = Ranking::CharacterRanking.paginate(:page => page, :per_page => per_page, :order => "#{sort} DESC, id ASC")

    nr = (page - 1) * per_page + 1
    returned_ranking_entries = @ranking_character_rankings.map do |ranking_entry|
      ranking_entry_hash = ranking_entry.attributes
      ranking_entry_hash[:rank] = nr
      ranking_entry_hash[:mundane_rank]  = ranking_entry.character.mundane_rank
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

  def self
    raise NotFoundError.new "Not Found."   unless current_character
    character = current_character
    sort = "overall_score"

    num_before = Ranking::CharacterRanking.where(
      "#{ sort } > ? or (#{ sort } = ? and id < ?)",
      character.ranking[sort.to_sym],
      character.ranking[sort.to_sym],
      character.id,
      ).count

    @ranking_character_ranking = Ranking::CharacterRanking.find_by_character_id(character.id)
    @ranking_character_ranking[:rank] = num_before + 1
    
    respond_to do |format|
      format.json { render json: include_root(@ranking_character_ranking, :character_ranking) }
    end
  end
end



