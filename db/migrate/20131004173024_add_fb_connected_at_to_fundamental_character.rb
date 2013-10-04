require 'httparty'
require 'identity_provider/access'


class AddFbConnectedAtToFundamentalCharacter < ActiveRecord::Migration
  
  def up
    add_column :fundamental_characters, :fb_player_id, :string
    add_column :fundamental_characters, :fb_player_id_connected_at, :datetime
    add_column :fundamental_characters, :fb_rejected_at, :datetime
    add_column :fundamental_characters, :gc_player_id, :string
    add_column :fundamental_characters, :gc_player_id_connected_at, :datetime
    add_column :fundamental_characters, :gc_rejected_at, :datetime
  
    identity_provider_access = IdentityProvider::Access.new({
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes:                     ['5dentity'],
    })
    
    Fundamental::Character.all.each do |character|
      response = identity_provider_access.fetch_identity(character.identifier)
      if response.code == 200
        data = response.parsed_response || {}
        character.fb_player_id              = data['fb_player_id']
        character.fb_player_id_connected_at = data['fb_player_id_connected_at']
        character.fb_rejected_at            = data['fb_rejected_at']
        character.gc_player_id              = data['gc_player_id']
        character.gc_player_id_connected_at = data['gc_player_id_connected_at']
        character.gc_rejected_at            = data['gc_rejected_at']
      end
    end
  end
  
  def down
    remove_column  :fundamental_characters,  :fb_player_id
    remove_column  :fundamental_characters,  :fb_player_id_connected_at
    remove_column  :fundamental_characters,  :fb_rejected_at
    remove_column  :fundamental_characters,  :gc_player_id
    remove_column  :fundamental_characters,  :gc_player_id_connected_at
    remove_column  :fundamental_characters,  :gc_rejected_at
  end
end
