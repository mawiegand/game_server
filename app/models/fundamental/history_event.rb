require 'identity_provider/access'

class Fundamental::HistoryEvent < ActiveRecord::Base
  
  belongs_to  :character, :class_name => "Fundamental::Character", :foreign_key => :character_id, :inverse_of => :history_events
  
  serialize   :data
  serialize   :localized_description
  
  def self.history_events_for_character_id(character_id)
    update_if_necessary(character_id)
    
    Fundamental::HistoryEvent.where(:character_id => character_id)
  end
  
  def self.update_if_necessary(character_id)

    last_update_at = Fundamental::HistoryEvent.where(:character_id => character_id).maximum(:updated_at)

    # check if update intervall is reached
    if last_update_at.nil? || GAME_SERVER_CONFIG['history_update_interval'].hours.ago >= last_update_at
      character = Fundamental::Character.find(character_id)
      
      identity_provider_access = IdentityProvider::Access.new({
        identity_provider_base_url: GAME_SERVER_CONFIG['identity_provider_base_url'],
        game_identifier:            GAME_SERVER_CONFIG['game_identifier'],
        scopes:                     ['5dentity'],
      })
      response = identity_provider_access.fetch_history_events(character.identifier)
      
      if response.code == 200
        response.parsed_response.each do |item|
          if Fundamental::HistoryEvent.exists?(item['id'])
            event = Fundamental::HistoryEvent.find(item['id'])
          else
            event = Fundamental::HistoryEvent.new
          end
          
          unless event.nil?
            event.id = item['id']
            event.data = item['data']
            event.localized_description = item['localized_description']
            event.character = character
            
            event.save
          end
        end
      else
        #Rails.logger.debug "An error occured while fetching history events! Http-Status: #{httpstatus}"
        Rails.logger.debug "An error occured while fetching history events! response: #{response}"
      end
    end
  end
end
