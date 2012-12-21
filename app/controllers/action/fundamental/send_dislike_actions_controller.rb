class Action::Fundamental::SendDislikeActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:character].nil? || params[:character][:id].blank?
    
    receiver = Fundamental::Character.find(params[:character][:id])
    old_dislikes = LikeSystem::Dislike.where('sender_id = ? and receiver_id = ? and created_at > ?',
                               current_character, receiver, 1.day.ago).all
                             
    if(old_dislikes.empty?)
      dislike = LikeSystem::Dislike.new(:sender => current_character, :receiver => receiver)
      dislike.save
    else
      raise BadRequestError.new('Allready sent dislike!')
    end

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

end
