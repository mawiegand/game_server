class Action::Fundamental::SendLikeActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:character].nil? || params[:character][:id].blank?

    receiver = Fundamental::Character.find(params[:character][:id])
    old_likes = LikeSystem::Like.where('sender_id = ? and receiver_id = ? and created_at > ?',
                               current_character, receiver, 1.day.ago).all
                             
    if(old_likes.empty?)
      like = LikeSystem::Like.new(:sender => current_character, :receiver => receiver)
      like.save
    else
      raise BadRequestError.new('Allready sent like!')
    end

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

end
