require 'five_d/access_token'
require 'httparty'

module IdentityProvider

  class Access
    
    def initialize(attributes = {})
      @attributes = attributes
    end

    def fetch_identity(identifier)
      get('/identities/' + identifier + '.json')
    end
  
    def fetch_identity_properties(identifier)
      get('/identities/' + identifier + '/character_properties.json')
    end
    
    def create_identity_property(identity_id, data_object)
      post('/identities/' + identifier + '/character_properties.json',
          {:resource_character_property => {:data => data_object, :identity_id => identifier}})
    end
    
    def change_identity_property(identity_id, data_object)
      put('/identities/' + identifier + '/character_properties.json',
          {:resource_character_property => {:data => data_object, :identity_id => identifier}})
    end

    protected
      
      def post(path, body = {})
        add_auth_token(query)
        HTTParty.post(@attributes[:identity_provider_base_url] + path, :body => body)
      end
  
      def put(path, body = {})
        add_auth_token(query)
        HTTParty.put(@attributes[:identity_provider_base_url] + path, :body => body)
      end
  
      def get(path, query = {})
        add_auth_token(query)
        HTTParty.get(@attributes[:identity_provider_base_url] + path, :query => query)
      end
      
      def add_auth_token(query)
        @auth_token = FiveD::AccessToken.generate_access_token(@attributes[:game_identifier], @attributes[:scopes]) if @auth_token.nil?
        query[:auth_token] = @auth_token.token
      end
  end
end