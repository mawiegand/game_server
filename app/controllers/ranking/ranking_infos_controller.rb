class Ranking::RankingInfosController < ApplicationController
  layout 'ranking'
  
  before_filter :authenticate

  def show
    @ranking_info = {}
    
    @ranking_info[:character_entries_count] = Ranking::CharacterRanking.all.count
    @ranking_info[:alliance_entries_count] = Ranking::AllianceRanking.non_empty.count
    @ranking_info[:fortress_entries_count] = Settlement::Settlement.fortress.count
    @ranking_info[:artifact_entries_count] = Fundamental::Artifact.visible.count

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: include_root(@ranking_info, :ranking_info) }
    end
  end
end
