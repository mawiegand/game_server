require_relative '../../lib/game_state/avatars'

class AddAvatarStringToFundamentalCharacter < ActiveRecord::Migration
  def change
    add_column :fundamental_characters, :avatar_string, :string

    avatar = GameState::Avatars.new
    Fundamental::Character.all.each do |char|
      char.avatar_string = avatar.create_random_avatar_string(char.male?)
      char.save
    end
  end
end
