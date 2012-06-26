class Action::Fundamental::LeaveAllianceActionsController < ApplicationController

  layout 'action'

  before_filter :authenticate


  # GET /action/military/attack_army_actions/new
  # GET /action/military/attack_army_actions/new.json
  def new
    respond_to do |format|
      format.json { render json: { :attacker_id => nil, :defender_id => nil} }
    end
  end

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create
    alliance = Fundamental::Alliance.find(params[:leave_alliance_action][:alliance_id])
    
    raise BadRequestError.new('no current character') if current_character.nil?
    raise ForbiddenError.new('tried to leave an alliance although character is in no alliance') if current_character.alliance_id.blank?
    raise ForbiddenError.new('tried to leave an alliance the character is not a member of')  unless current_character.alliance_id == alliance.id

    alliance.remove_character(current_character)    
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
