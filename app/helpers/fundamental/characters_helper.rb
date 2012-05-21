module Fundamental::CharactersHelper
  
  def fetch_identity(identifier)
    response = HTTParty.get(GAME_SERVER_CONFIG['identity_provider_base_url'] + '/identities/'+request_access_token.identifier+'.json')   
    if !response.nil? && response['identifier'] 
      return response
    else 
      logger.warning 'Could not fetch identity of identifier #{identifier} from identity provider.'
      return {}
    end
  end
  
end
