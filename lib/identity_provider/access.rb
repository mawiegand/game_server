require 'five_d/access_token'
require 'httparty'

module IdentityProvider

  class Access
    
    def initialize(attributes = {})
      @attributes = attributes
    end

    def fetch_identity(identifier)
      get('/identities/' + identifier)
    end
  
    def fetch_identity_properties(identifier)
      get('/identities/'  + identifier + '/character_properties')
    end
    
    def create_character_property(identifier, data_object)
      post('/identities/' + identifier + '/character_properties', {:resource_character_property => {:data => data_object}})
    end
    
    def change_character_property(identifier, data_object)
      put('/resource/character_properties/' + identifier, {:resource_character_property => {:data => data_object}})
    end
    
    def change_character_passwort(identifier, password)
      put('/identities/' + identifier, {:identity => {:password => password, :password_confirmation => password}})
    end
    
    def deliver_message_notification(recipient, sender, message)
      
      subject = "Du hast soeben eine Nachricht von #{sender.name} in Wack-a-Doo erhalten."
      body    = "Betreff: #{message.subject}\n\n Log Dich jetzt unter https://wack-a-doo.de ein, um die ganze Nachricht zu lesen."

      if recipient.premium_account?
        subject = "Du hast soeben eine Nachricht von #{sender.name}  in Wack-a-Doo erhalten."
        body    = "Betreff: #{message.subject}\n\n   #{CGI::escapeHTML(message.body)} Log Dich jetzt unter https://wack-a-doo.de ein, um auf die Nachricht zu antworten."        
      end
      
      notification = {
        recipient_id:             recipient.identifier,
        recipient_character_name: recipient.name,
        sender_id:                sender.identifier,
        sender_character_name:    sender.name,
        subject:                  subject,
        body:                     body,
      }
      post("/identities/#{recipient.identifier}/messages", { :message => notification })
    end

    def post_result(character, round_number, round_name, won = false)
      return                            if character.ranking.nil?
      resource_result = {
        round_number:    round_number,
        round_name:      round_name,
        individual_rank: character.ranking.overall_rank,
        character_name:  character.name,
        won:             won,
      }
      if !character.alliance.nil? 
        resource_result[:alliance_tag]  = character.alliance.tag
        resource_result[:alliance_name] = character.alliance.name
        resource_result[:alliance_rank] = character.alliance.ranking.overall_rank
      end
      post('/identities/' + character.identifier + '/results', {:resource_result => resource_result})
    end

    def post_history_event(identifier, data_object, description = "an awe history event")
      return                            if identifier.nil?
      resource_history = {
        data:                  data_object,
        localized_description: description,
      }
      post('/identities/' + identifier + '/histories', {:resource_history => resource_history})
    end

    protected
      
      def post(path, body = {})
        Rails.logger.debug "POST BODY #{ body }."
        add_auth_token(body)
        HTTParty.post(@attributes[:identity_provider_base_url] + path, 
                      :body => body,  :headers => { 'Accept' => 'application/json'})
      end
  
      def put(path, body = {})
        add_auth_token(body)
        HTTParty.put(@attributes[:identity_provider_base_url] + path, 
                     :body => body,   :headers => { 'Accept' => 'application/json'})
      end
  
      def get(path, query = {})
        add_auth_token(query)
        HTTParty.get(@attributes[:identity_provider_base_url] + path, 
                     :query => query, :headers => { 'Accept' => 'application/json'})
      end
      
      def add_auth_token(query)
        @auth_token = FiveD::AccessToken.generate_access_token(@attributes[:game_identifier], @attributes[:scopes]) if @auth_token.nil?
        query[:auth_token] = @auth_token.token
      end
  end
end