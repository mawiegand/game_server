class Action::Fundamental::ChangeAllianceDescriptionActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:change_alliance_description_action].nil? || params[:change_alliance_description_action][:alliance_id].blank? || params[:change_alliance_description_action][:description].blank?

    raise ForbiddenError.new('tried to do a leader action although not even in an alliance') if current_character.alliance_id.blank?
    raise ForbiddenError.new('tried to do change wrong alliance') unless current_character.alliance_id == params[:change_alliance_description_action][:alliance_id]
    raise ForbiddenError.new('only leader can kick member') unless current_character.alliance_leader?
    
    alliance = currenct_character.alliance
    alliance.description = params[:change_alliance_description_action][:description].strip

    raise BadRequestError.new('saving the alliance description did fails.')  unless alliance.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
