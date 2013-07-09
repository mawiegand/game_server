require 'game_state/avatars'

class Action::Fundamental::ChangeAvatarActionsController < ApplicationController
  layout 'action'

  #before_filter :authenticate

  # create and return new avatar
  def index
    raise BadRequestError.new('no current character') if current_character.nil?
    avatar = GameState::Avatars.new
    new_avatar_string = avatar.create_random_avatar_string(current_character.gender.nil? || current_character.gender == 'male')

    respond_to do |format|
      format.json { render json: {'avatar_string' => new_avatar_string}, status: :ok }
      format.text { render text: new_avatar_string, status: :ok }
    end
  end

  # save avatar
  def create
    raise BadRequestError.new('no current character') if current_character.nil?
    #raise BadRequestError.new('missing parameter(s) ') if params[:avatar_string].nil?
    raise BadRequestError.new("blank parameter(s)") if params[:avatar_string].blank?

    #check if avatar string is conform
    current_character.avatar_string = params[:avatar_string]
    current_character.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end 
  end
end
