class Action::Fundamental::SendAllianceApplicationActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:send_alliance_application_action].nil? || params[:send_alliance_application_action][:alliance_id].blank?
    
    alliance = Fundamental::Alliance.find(params[:send_alliance_application_action][:alliance_id])

		raise BadRequestError.new('alliance application could not be delivered') unless Messaging::Message.generate_alliance_application_message(current_character, alliance)

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
