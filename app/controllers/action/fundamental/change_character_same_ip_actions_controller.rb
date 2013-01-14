class Action::Fundamental::ChangeCharacterSameIpActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:character].nil?

    current_character.same_ip = params[:character][:same_ip]
     
    respond_to do |format|
      if current_character.save
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: {}, status: :unprocessable_entity }
      end
    end
  end
  
end
