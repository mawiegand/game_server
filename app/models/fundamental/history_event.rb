require 'identity_provider/access'

class Fundamental::HistoryEvent < ActiveRecord::Base
  
  belongs_to  :character, :class_name => "Fundamental::Character", :foreign_key => :character_id, :inverse_of => :history_events
  
  serialize   :data
  serialize   :localized_description
  
  def self.history_events_for_character_id(character_id)
    update_if_necessary(character_id)
    
    Fundamental::HistoryEvent.find(:all, :conditions => { :character_id => character_id})
  end
  
  def self.update_if_necessary(character_id)
    @fundamental_character = Fundamental::Character.find(character_id)
    identity_provider_access = IdentityProvider::Access.new({
      identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
      game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
      scopes:                     ['5dentity'],
    })
    response = identity_provider_access.fetch_history_events(@fundamental_character.identifier)
    Rails.logger.debug "HISTORY #{response.code}"
    
    httpstatus = response.code
    
    if httpstatus == 200
      response.parsed_response.each do |item|
        if Fundamental::HistoryEvent.exists?(item['id'])
          event = Fundamental::HistoryEvent.find(item['id'])
		else
          event = Fundamental::HistoryEvent.new
        end
        
        if event != nil
          event.id = item['id']
          event.created_at = item['created_at']
          event.updated_at = item['updated_at']
          event.data = item['data']
          event.localized_description = item['localized_description']
          event.character = @fundamental_character
          
          event.save
        end
      end
    else
      Rails.logger.debug "An error occured while fetching history events! Http-Status: #{httpstatus}"
    end
  end
end
