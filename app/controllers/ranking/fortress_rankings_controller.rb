class Ranking::FortressRankingsController < ApplicationController
  layout "ranking"
  
  # GET /ranking/fortress_rankings
  # GET /ranking/fortress_rankings.json  
  def index
    
    @fortresses = if params[:sort] == 'defense_bonus'
      Settlement::Settlement.fortress.highest_defense_bonus
    elsif params[:sort] == 'income'
      Settlement::Settlement.fortress.highest_normalized_income
    else
      Settlement::Settlement.fortress.highest_tax_rate
    end

    @title = "Fortress Ranking"
    
    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: @fortress }
    end    
  end
  
end
