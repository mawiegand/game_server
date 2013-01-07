class Action::Fundamental::SendDislikeActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:character].nil? || params[:character][:id].blank?
    
    receiver = Fundamental::Character.find(params[:character][:id])
    raise BadRequestError.new('cannot dislike yourself') if receiver == current_character    
    
    old_dislikes = LikeSystem::Dislike.where('sender_id = ? and receiver_id = ? and created_at > ?',
                               current_character, receiver, 1.day.ago).count
                             
    raise ConflictError.new('Allready sent dislike!')  if old_dislikes > 0
    dislike = LikeSystem::Dislike.new(:sender => current_character, :receiver => receiver)

    # propagate change manually as counter cache updates don't trigger after save handler
    receiver.propagate_dislike_changes

    respond_to do |format|
      if dislike.save
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: {}, status: :not_found }
      end
    end
  end

end
