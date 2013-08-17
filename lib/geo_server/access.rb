require 'five_d/access_token'
require 'httparty'

module GeoServer

  class Access
    
    def initialize(attributes = {})
      @attributes = attributes
    end

    def fetch_fundamental_character_self
      get('/fundamental/characters/self')
    end

    def open_treasure(treasure_id, current_identifier)
      response = post('/action/treasure/open_treasure_actions', {:id => treasure_id, :identifier => current_identifier})
      response.code == 200
    end

    protected
      
      def post(path, body = {})
        HTTParty.post(@attributes[:geo_server_provider_base_url] + path,
                      :body => body, :headers => { 'Accept' => 'application/json', 'Authorization' => "Bearer #{ @attributes[:auth_token] }"})
      end
  
      def put(path, body = {})
        HTTParty.put(@attributes[:geo_server_provider_base_url] + path,
                     :body => body, :headers => { 'Accept' => 'application/json', 'Authorization' => "Bearer #{ @attributes[:auth_token] }"})
      end
  
      def get(path, query = {})
        HTTParty.get(@attributes[:geo_server_provider_base_url] + path,
                     :query => query, :headers => { 'Accept' => 'application/json', 'Authorization' => "Bearer #{ @attributes[:auth_token] }"})
      end
  end
end