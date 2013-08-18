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

    def open_treasure(treasure_id, character)
      
      response = post('/action/treasure/open_treasure_actions', 
                      {:open_treasure_action => { :id => treasure_id, 
                                                  :identifier => character.identifier, 
                                                  :character_level => character.level}})
                                                  
                                          
    end


    def get_treasure(treasure_id)
      response = get("/treasure/treasures/#{treasure_id}")
      
      if response.code == 200 
        return response.parsed_response
      else 
        return nil
      end 
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