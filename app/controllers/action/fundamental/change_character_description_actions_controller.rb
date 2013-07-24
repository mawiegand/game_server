class Action::Fundamental::ChangeCharacterDescriptionActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise ForbiddenError.new('currently disabled')

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:change_character_description_action].nil? || params[:change_character_description_action][:description].blank?

    current_character.description = params[:change_character_description_action][:description].strip

    raise BadRequestError.new('saving the character description did fail.')  unless current_character.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
