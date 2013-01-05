class Ranking::FortressRankingsController < ApplicationController
  layout "ranking"
  
  # GET /ranking/fortress_rankings
  # GET /ranking/fortress_rankings.json  
  def index
    
    @fortresses = if params[:sort] == 'defense'
      Settlement::Settlement.fortress.highest_defense_bonus
    elsif params[:sort] == 'income'
      Settlement::Settlement.fortress.highest_normalized_income
    else
      Settlement::Settlement.fortress.highest_tax_rate
    end

    per_page = params[:per_page].blank? ? 5 : params[:per_page].to_i
    page     = params[:page].blank?     ? 1 : params[:page].to_i

    ranking_entries = @fortresses.paginate(:page => page, :per_page => per_page)
    
    nr = (page - 1) * per_page + 1     
    returned_ranking_entries = []                                              
    ranking_entries.each do |ranking_entry|
      ranking_entry_hash = ranking_entry.attributes
      ranking_entry_hash[:rank] = nr
      ranking_entry_hash[:region_name] = ranking_entry.region.name unless ranking_entry.region.nil?
      ranking_entry_hash[:owner_name] = ranking_entry.owner.name unless ranking_entry.owner.nil?
      ranking_entry_hash[:alliance_tag] = ranking_entry.alliance.tag unless ranking_entry.alliance.nil?
      ranking_entry_hash[:resource_production_score] = (ranking_entry.resource_production_score / (ranking_entry.tax_rate * 100)).round
      returned_ranking_entries << ranking_entry_hash
      nr += 1
    end
                                                                    
    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: returned_ranking_entries.as_json }
    end
  end
end
