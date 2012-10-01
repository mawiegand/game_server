class Action::Fundamental::TrackCharacterConversionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:state].blank?
    
    if params[:state] === "reached_game"
      current_character.reached_game = DateTime.now
      current_character.save
    else
      raise BadRequestError.new ("unkown conversion state #{params[:state]}")
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
