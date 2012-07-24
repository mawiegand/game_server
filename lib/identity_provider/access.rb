require 'five_d/access_token'
require 'httparty'

module IdentityProvider

  class Access

    def get_start_bonus(character_id)
      get('/identities/' + character_id.to_s + '/character_properties.json')
    end
    
    def create_start_bonus(character_id)
      data_object = {:ping => :pong}
      post('/identities/' + character_id.to_s + '/character_properties.json',
          {:resource_character_property => {:data => data_object, :identity_id => 2}})
    end
    
    def change_start_bonus(character_id)
      data_object = {:ping => :pong}
      put('/identities/' + character_id.to_s + '/character_properties.json', {:data => data_object})
    end
    
    protected
      
      def post(path, query = {})
        add_auth_token(query)
        HTTParty.post(GAME_SERVER_CONFIG['identity_provider_base_url'] + path, :query => query).parsed_response
      end
  
      def put(path, query = {})
        add_auth_token(query)
        HTTParty.put(GAME_SERVER_CONFIG['identity_provider_base_url'] + path, :query => query).parsed_response
      end
  
      def get(path, query = {})
        add_auth_token(query)
        HTTParty.get(GAME_SERVER_CONFIG['identity_provider_base_url'] + path, :query => query).parsed_response
      end
      
      def add_auth_token(query)
        @auth_token = FiveD::AccessToken.generate_access_token('WACKADOO', ['5dentity']) if @auth_token.nil?
        query[:auth_token] = @auth_token.token
      end
  end
end