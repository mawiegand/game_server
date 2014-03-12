class Action::Fundamental::AllianceLeaderVoteActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:alliance_leader_vote_action].nil? || params[:alliance_leader_vote_action][:alliance_id].blank? 

    raise ForbiddenError.new('tried to do an alliance action although not even in an alliance') if current_character.alliance_id.blank?
    raise ForbiddenError.new('tried to change setting on wrong alliance') unless current_character.alliance_id == params[:alliance_leader_vote_action][:alliance_id].to_i
    
    # Currently returns list and the first entry is choosen, maybe there is a better way (Could be improved!)
    vote = current_character.alliance_leader_vote
    vote.candidate_id = params[:alliance_leader_vote_action][:candidate_id]
    raise BadRequestError.new('saving new vote failed')  unless vote.save
    alliance = current_character.alliance
    alliance.determine_new_leader
    
    raise BadRequestError.new('saving new leader failed')  unless alliance.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
