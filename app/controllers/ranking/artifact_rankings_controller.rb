class Ranking::ArtifactRankingsController < ApplicationController
  layout "ranking"
  
  # GET /ranking/artifact_rankings
  # GET /ranking/artifact_rankings.json
  def index
    
    @artifacts = if params[:sort] == 'name'
      Fundamental::Artifact.visible.order('type_id asc')
    elsif params[:sort] == 'owner_name'
      Fundamental::Artifact.visible.joins(:owner).order('fundamental_characters.name asc')
    elsif params[:sort] == 'region_name'
      Fundamental::Artifact.visible.joins(:region).order('map_regions.name asc')
    elsif params[:sort] == 'last_captured_at'
      Fundamental::Artifact.visible.order('last_captured_at asc')
    elsif params[:sort] == 'last_initiated_at'
      Fundamental::Artifact.visible.order('last_initiated_at asc')
    else
      Fundamental::Artifact.visible.order('id asc')
    end

    per_page = params[:per_page].blank? ? 25 : params[:per_page].to_i
    page     = params[:page].blank?     ? 1  : params[:page].to_i

    @artifacts = @artifacts.paginate(:page => page, :per_page => per_page)
    
    nr = (page - 1) * per_page + 1     
    returned_ranking_entries = @artifacts.map do |ranking_entry|
      ranking_entry_hash = ranking_entry.attributes
      ranking_entry_hash[:rank] = nr
      ranking_entry_hash[:name] = ranking_entry.artifact_type[:name]
      ranking_entry_hash[:owner_name] = ranking_entry.owner.name
      ranking_entry_hash[:alliance_tag] = ranking_entry.owner.alliance_tag
      ranking_entry_hash[:region_name] = ranking_entry.region.name unless ranking_entry.region.nil?
      nr += 1
      ranking_entry_hash
    end
                                                                    
    respond_to do |format|
      format.html    # index.html.erb
      format.json { render json: include_root(returned_ranking_entries, :artifact_ranking) }
    end
  end
end
