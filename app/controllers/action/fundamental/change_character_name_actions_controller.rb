class Action::Fundamental::ChangeCharacterNameActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequest.new('missing parameter(s)') if params[:character].nil? || params[:character][:name].blank?

    current_character.change_name_transaction(params[:character][:name]) 
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
