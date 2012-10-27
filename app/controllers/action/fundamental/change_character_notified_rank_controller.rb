class Action::Fundamental::ChangeCharacterNotifiedRankActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequest.new('missing parameter(s)') if params[:character].nil? || (params[:character][:notified_mundane_rank].nil? && params[:character][:notified_sacred_rank].nil?)

    current_character.notified_mundane_rank = current_character.mundane_rank unless params[:character][:notified_mundane_rank].nil?  
    current_character.notified_sacred_rank  = current_character.sacred_rank  unless params[:character][:notified_sacred_rank].nil?  
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
