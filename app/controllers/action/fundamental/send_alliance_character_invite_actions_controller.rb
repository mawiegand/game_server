class Action::Fundamental::SendAllianceCharacterInviteActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:send_alliance_character_invite_action].nil? || params[:send_alliance_character_invite_action][:character_invite_name].blank?

    raise ForbiddenError.new('only leader can invite characters') unless current_character.alliance_leader?
    
    character_invite = Fundamental::Character.find_by_name_case_insensitive(params[:send_alliance_character_invite_action][:character_invite_name])
    raise NotFoundError.new('character invite not found') if character_invite.nil?

		raise BadRequestError.new('character invite could not be delivered') unless Messaging::Message.generate_alliance_character_invite_message(character_invite, current_character.alliance)

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
