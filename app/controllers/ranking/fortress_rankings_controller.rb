class Ranking::FortressRankingsController < ApplicationController
  layout "ranking"
  
  # GET /ranking/fortress_rankings
  # GET /ranking/fortress_rankings.json  
  def index
    
    @fortresses = if params[:sort] == 'defense'
      Settlement::Settlement.fortress.highest_defense_bonus
    elsif params[:sort] == 'name'
      Settlement::Settlement.fortress.joins(:region).order('map_regions.name asc')
    elsif params[:sort] == 'income'
      Settlement::Settlement.fortress.highest_normalized_income
    else
      Settlement::Settlement.fortress.highest_tax_rate
    end

    per_page = params[:per_page].blank? ? 25 : params[:per_page].to_i
    page     = params[:page].blank?     ? 1  : params[:page].to_i

    @fortresses = @fortresses.paginate(:page => page, :per_page => per_page)
    
    nr = (page - 1) * per_page + 1
    returned_ranking_entries = @fortresses.map do |ranking_entry|
      ranking_entry_hash = ranking_entry.attributes
      ranking_entry_hash[:rank] = nr
      ranking_entry_hash[:character_id] = ranking_entry.owner_id
      ranking_entry_hash[:character_name] = ranking_entry.owner.name
      ranking_entry_hash[:region_name] = ranking_entry.region.name unless ranking_entry.region.nil?
      ranking_entry_hash[:resource_production_score] = (ranking_entry.resource_production_score / (ranking_entry.tax_rate * 100)).round
      nr += 1
      ranking_entry_hash
    end
                                                                    
    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: include_root(returned_ranking_entries, :fortress_ranking) }
    end
  end
end
