class Action::Fundamental::ConnectFacebookActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter') if params[:connect_facebook_action].nil? || params[:connect_facebook_action][:fb_player_id].blank?  || params[:connect_facebook_action][:fb_access_token].blank?
    
    current_character.connect_facebook_transaction(params[:connect_facebook_action][:fb_player_id], params[:connect_facebook_action][:fb_access_token])
    
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
