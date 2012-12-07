class Action::Fundamental::SendDislikeActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:character].nil? || params[:character][:id].blank?
    
    dislike = LikeSystem::Dislike.new
    dislike.sender = current_character
    dislike.receiver = Fundamental::Character.find(params[:character][:id])
    dislike.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

end
