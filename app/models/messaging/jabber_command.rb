class Messaging::JabberCommand < ActiveRecord::Base
  
  belongs_to :character,  :class_name => "Fundamental::Character", :foreign_key => "character_id"
    
  def self.open_room(name)
    Messaging::JabberCommand.new({
      command: 'muc_create',
      room: name,
    })
  end
  
  def self.close_room(name)
    Messaging::JabberCommand.new({
      command: 'muc_delete',
      room: name,
    })
  end
  
  def self.grant_access(character, room)
    Messaging::JabberCommand.new({
      command: 'auth_add',
      room: room,
      data: character.identifier,
    })
  end
  
  def self.revoke_access(character, room)
    Messaging::JabberCommand.new({
      command: 'auth_delete',
      room: room,
      data: character.identifier,
    })
  end
  
end
