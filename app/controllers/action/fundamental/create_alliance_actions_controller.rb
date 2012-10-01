class Action::Fundamental::CreateAllianceActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create
    raise BadRequest.new('no current character') if current_character.nil?
    raise ForbiddenError.new('tried to create an alliance although character is in alliance') unless current_character.alliance_id.blank?
    raise BadRequest.new('missing parameter(s)') if params[:alliance].nil? || params[:alliance][:tag].blank? || params[:alliance][:name].blank?
    raise ForbiddenError.new('tried to create an alliance without having the ability') unless current_character.can_create_alliance?



    Fundamental::Alliance.create_alliance(params[:alliance][:tag], params[:alliance][:name], current_character)    
    
    respond_to do |format|
      format.json { render json: {}, status: :created }
    end
  end
  
end
