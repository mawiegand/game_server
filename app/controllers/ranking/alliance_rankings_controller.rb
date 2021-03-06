class Ranking::AllianceRankingsController < ApplicationController
  layout "ranking"
  
  # GET /ranking/character_rankings
  # GET /ranking/character_rankings.json
  def index
    if !params[:mark].blank?
      alliance = Fundamental::Alliance.find_by_id(params[:mark])
      @marked_alliance = alliance unless alliance.nil?
    elsif current_character
      @marked_alliance = current_character.alliance
    end
    
    per_page = params[:per_page].blank? ? 25 : params[:per_page].to_i
    
    sort = "num_fortress"
    sort = "num_fortress"   if params[:sort] == 'fortress'
    sort = "overall_score"  if params[:sort] == 'overall'
    sort = "resource_score" if params[:sort] == 'resource'
    sort = "num_members"    if params[:sort] == 'members'
    sort = "kills"          if params[:sort] == 'kills'
    sort = "(1.0 * num_fortress / num_members)" if params[:sort] == 'fortressmembers'

    if params[:page].blank? && @marked_alliance
      num_before = Ranking::AllianceRanking.non_empty.where([
        "#{ sort } > ? or (#{ sort } = ? and id < ?)",
        @marked_alliance.ranking[sort.to_sym],
        @marked_alliance.ranking[sort.to_sym],
        @marked_alliance.id,
      ]).count
      page = num_before / per_page + 1
    elsif !params[:page].blank?
      page = params[:page].to_i
    else
      page = 1
    end

    @ranking_alliance_rankings = Ranking::AllianceRanking.non_empty.includes(:alliance => [:artifacts]).paginate(:page => page, :per_page => per_page, :order => "#{sort} DESC, num_members ASC")
    
    nr = (page - 1) * per_page + 1
    returned_ranking_entries = @ranking_alliance_rankings.map do |ranking_entry|
      ranking_entry_hash = ranking_entry.attributes
      ranking_entry_hash[:rank] = nr
      ranking_entry_hash[:regions_per_member] = ranking_entry_hash['num_members'] == 0 ? 0 : (1.0 * (ranking_entry_hash['num_fortress']) / ranking_entry_hash['num_members']).round(1)
      ranking_entry_hash[:artifacts] = ranking_entry.alliance.artifacts.count
      nr += 1
      ranking_entry_hash
    end
                                                                   
    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: include_root(returned_ranking_entries, :alliance_ranking) }
    end
  end
end
