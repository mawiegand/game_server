class Action::Fundamental::ChangeAllianceAutoJoinActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:change_alliance_auto_join_action].nil? || params[:change_alliance_auto_join_action][:alliance_id].blank? 

    raise ForbiddenError.new('tried to do a leader action although not even in an alliance') if current_character.alliance_id.blank?
    raise ForbiddenError.new('tried to change setting on wrong alliance') unless current_character.alliance_id == params[:change_alliance_auto_join_action][:alliance_id].to_i
    raise ForbiddenError.new('only leader can change auto join setting') unless current_character.alliance_leader?
    
    alliance = current_character.alliance
    alliance.auto_join_disabled = !((params[:change_alliance_auto_join_action][:auto_join_setting] || "0") == "1")
    
    raise BadRequestError.new('saving the auto join setting did fail.')  unless alliance.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
