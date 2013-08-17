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
      response = post('https://test1.wack-a-doo.de/geo_server/action/treasure/open_treasure_actions', {:open_treasure_action => {:id => treasure_id, :identifier => current_identifier}})
      response.code == 200
    end

    protected
      
      def post(path, body = {})
        HTTParty.post(GAME_SERVER_CONFIG['geo_server_base_url'] + path,
                      :body => body, :headers => { 'Accept' => 'application/json', 'Authorization' => "Bearer #{ @attributes[:auth_token] }"})
      end
  
      def put(path, body = {})
        HTTParty.put(GAME_SERVER_CONFIG['geo_server_base_url'] + path,
                     :body => body, :headers => { 'Accept' => 'application/json', 'Authorization' => "Bearer #{ @attributes[:auth_token] }"})
      end
  
      def get(path, query = {})
        HTTParty.get(GAME_SERVER_CONFIG['geo_server_base_url'] + path,
                     :query => query, :headers => { 'Accept' => 'application/json', 'Authorization' => "Bearer #{ @attributes[:auth_token] }"})
      end
  end
end