class Action::Fundamental::ChangeCharacterGenderActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:character].nil? || params[:character][:gender].blank?
    raise BadRequestError.new('wrong gender') if params[:character][:gender] != "male" && params[:character][:gender] != "female"

    current_character.change_gender_transaction(params[:character][:gender]) 
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
