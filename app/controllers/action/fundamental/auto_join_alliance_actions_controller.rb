class Action::Fundamental::AutoJoinAllianceActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create
    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('tried to join an alliance although character is already in an alliance') unless current_character.alliance.nil?
    raise UnauthorizedError.new('no character given') if params[:auto_join_alliance_action][:character_id].nil?
    raise UnauthorizedError.new('tried to access another character') if params[:auto_join_alliance_action][:character_id].to_i != current_character.id
    raise ForbiddenError.new('joining new alliance not allowed') if !current_character.can_join_alliance?


    alliance = Fundamental::Alliance.select_auto_join_alliance(current_character)

    raise NotFoundError.new('no suitable alliance found') if alliance.nil?
    raise ConflictError.new("too many members in alliance") if alliance.full?
    
    alliance.add_character(current_character)
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
