require 'game_state/avatars'

class AddAvatarStringToFundamentalCharacter < ActiveRecord::Migration
  def up
    add_column :fundamental_characters, :avatar_string, :string

    avatar = GameState::Avatars.new
    Fundamental::Character.all.each do |char|
      avatar.create_avatar_string_from_id_and_gender(char.id, char.male?)
      char.avatar_string = avatar.avatar_string
      char.save
    end
  end
  
  def down
    remove_column :fundamental_characters, :avatar_string
  end
end
