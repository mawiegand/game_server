class Action::Fundamental::KickAllianceMemberActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions.json
  def create
    raise BadRequestError.new('no current character')       if     current_character.nil?
    raise ForbiddenError.new('tried to do a leader action although not even in an alliance') if current_character.alliance_id.blank?
    raise ForbiddenError.new('only leader can kick member') unless current_character.alliance_leader?
    
    raise BadRequestError.new('missing parameter(s)')       if params[:kick_action].nil? || !params[:kick_action].has_key?(:character_id)
    character = Fundamental::Character.find_by_id(params[:kick_action][:character_id])
    raise NotFoundError.new('character not found')          if character.nil?

    raise ForbiddenError.new('leader cannot kick himself')  if     character             == current_character
    raise ForbiddenError.new('tried to kick a non-member')  unless character.alliance_id == current_character.alliance_id
    raise ForbiddenError.new('leaders cannot be kicked')    if     character.alliance_leader?
    
    if !current_character.alliance.kick_character(character, current_character)
      raise InternalServerError.new('kicking failed for unknown reasons.')
    end
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
