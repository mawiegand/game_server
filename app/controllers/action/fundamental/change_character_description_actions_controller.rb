class Action::Fundamental::ChangeCharacterDescriptionActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:change_character_description_action].nil?

    current_character.description = (params[:change_character_description_action][:description] || "").strip

    raise ConflictError.new('description too long')  if current_character.description.length > GAME_SERVER_CONFIG['description_max_length']

    raise BadRequestError.new('saving the character description did fail.')  unless current_character.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
