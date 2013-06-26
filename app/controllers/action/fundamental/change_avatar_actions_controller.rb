require 'game_state/avatars'

class Action::Fundamental::ChangeAvatarActionsController < ApplicationController
  layout 'action'

  #before_filter :authenticate

  # create and return new avatar
  def index
    avatar = GameState::Avatars.new
    new_avatar_string = avatar.create_random_avatar_string(current_character.gender == 'male')

    respond_to do |format|
      format.json { render json: {'avatar_string' => new_avatar_string, status: :ok }
    end
  end

  # save avatar
  def create
  end
end
