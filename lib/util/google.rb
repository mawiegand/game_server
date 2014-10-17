require 'base64'

module Util
  class GoogleManager

    OAUTH_BASE_URL = "https://accounts.google.com/o/oauth2/token"
    API_BASE_URL = "https://www.googleapis.com/androidpublisher/v1/"

    def self.fetch_auth_tokens
      config = Google::AppConfig.the_app_config

      response = HTTParty.post(
          OAUTH_BASE_URL,
          body: {
              grant_type:    :authorization_code,
              code:          config.code,
              client_id:     config.client_id,
              client_secret: config.client_secret,
              redirect_uri:  config.redirect_uri,
              scope:         'https://www.googleapis.com/auth/androidpublisher',
          },
          verify: false,
      )

      Rails.logger.debug "googe api response: #{response}"

      if response.code == 200
        config.access_token = response.parsed_response['access_token']
        config.refresh_token = response.parsed_response['refresh_token'] if !response.parsed_response['refresh_token'].blank?
        config.reset_expiration(response.parsed_response['expires_in'].to_i)
        config.save
      else
        false
      end
    end

    def self.refresh_access_token
      config = Google::AppConfig.the_app_config

      response = HTTParty.post(
          OAUTH_BASE_URL,
          body: {
              grant_type:    :refresh_token,
              client_id:     config.client_id,
              client_secret: config.client_secret,
              refresh_token: config.refresh_token,
              scope:         'https://www.googleapis.com/auth/androidpublisher',
          },
          verify: false,
      )

      Rails.logger.debug "googe api response: #{response}"

      if response.code == 200
        config.access_token = response.parsed_response['access_token']
        config.reset_expiration(response.parsed_response['expires_in'].to_i)
        config.save
      else
        false
      end
    end

  end
end