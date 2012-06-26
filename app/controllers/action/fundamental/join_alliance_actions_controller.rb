class Action::Fundamental::JoinAllianceActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create
    alliance = Fundamental::Alliance.find_by_tag(params[:alliance][:tag])
    
    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('tried to join an alliance although character is already in an alliance') unless current_character.alliance_id.blank?
    raise UnauthorizedError.new('no alliance password given') if params[:alliance][:password].nil?
    raise NotFoundError.new('alliance with given tag not found') if alliance.nil?
    raise ForbiddenError.new('wrong alliance password') unless alliance.password == params[:alliance][:password]

    alliance.add_character(current_character)    
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
