require 'base64'

module Util
  class GoogleManager

    OAUTH_BASE_URL = "https://accounts.google.com/o/oauth2/token"
    API_BASE_URL = "https://www.googleapis.com/androidpublisher/v1/"

    #def self.parse_signed_request(signed_request, secret, max_age=3600)
    #  encoded_sig, encoded_envelope = signed_request.split('.', 2)
    #  envelope = JSON.parse(self.base64_url_decode(encoded_envelope))
    #  algorithm = envelope['algorithm']
    #  return nil if algorithm != 'HMAC-SHA256'
    #  return nil if envelope['issued_at'] < Time.now.to_i - max_age
    #  return nil if self.base64_url_decode(encoded_sig) != OpenSSL::HMAC.hexdigest('sha256', secret, encoded_envelope).split.pack('H*')
    #  envelope
    #end

    def self.refresh_auth_tokens(logger)
      config = Google::AppConfig.the_app_config

      response = HTTParty.post(
          OAUTH_BASE_URL,
          :body => {
              grant_type:    'authorization_code',
              code:          config.code,
              client_id:     config.client_id,
              client_secret: config.client_secret,
              redirect_uri:  config.redirect_uri
          },
          verify: false
      )

      if response.code == 200
        config.access_token = response.parsed_response['access_token']
        config.refresh_token = response.parsed_response['refresh_token']
        config.reset_expiration(response.parsed_response['expires_in'].to_i)
        config.save
      else
        false
      end
    end

    def self.refresh_access_token
      config = Google::AppConfig.the_app_config
      #url = "https://graph.facebook.com/oauth/access_token?client_id=#{config.app_id}&client_secret=#{config.app_secret}&grant_type=client_credentials"
      #
      #response = HTTParty.post(url)
      #
      #if response.code == 200
      #  config.app_token = response.parsed_response.split('=')[1]
      #  config.save
      #end
    end

    private

      def self.base64_url_decode(str)
        str += '=' * (4 - str.length.modulo(4))
        Base64.decode64(str.tr('-_','+/'))
      end

  end
end