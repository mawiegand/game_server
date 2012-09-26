class Action::Fundamental::ChangeCharacterPasswordActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing password') if params[:character].nil? || params[:character][:password].blank?

    current_character.change_password_transaction(params[:character][:password])
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
