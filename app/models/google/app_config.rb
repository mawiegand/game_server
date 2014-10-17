require 'credit_shop'

class Google::AppConfig < ActiveRecord::Base

  OAUTH_BASE_URL = 'https://accounts.google.com/o/oauth2/'
  API_BASE_URL   = 'https://www.googleapis.com/androidpublisher/v1/'
  API_SCOPE      = 'https://www.googleapis.com/auth/androidpublisher'

  PACKAGE_NAME   = 'com.wackadoo.wackadoo_client'
  RESPONSE_KIND  = 'androidpublisher#productPurchase'

  def self.the_app_config
    Google::AppConfig.find(1)
  end

  def self.set_app_code(code)
    config = Google::AppConfig.the_app_config
    config.code = code
    config.access_token = nil
    config.expires_at = nil
    config.save
  end

  def self.fetch_auth_tokens
    config = Google::AppConfig.the_app_config

    response = HTTParty.post(
        OAUTH_BASE_URL + 'token',
        body: {
            grant_type:    :authorization_code,
            code:          config.code,
            client_id:     config.client_id,
            client_secret: config.client_secret,
            redirect_uri:  config.redirect_uri,
            scope:         API_SCOPE,
        },
        verify: false,
    )

    if response.code == 200
      config.access_token = response.parsed_response['access_token']
      config.refresh_token = response.parsed_response['refresh_token'] if !response.parsed_response['refresh_token'].blank?
      config.reset_expiration(response.parsed_response['expires_in'])
      config.save
    else
      false
    end
  end

  def self.refresh_access_token
    config = Google::AppConfig.the_app_config
    config.refresh_access_token!
  end

  def refresh_access_token!
    response = HTTParty.post(
        OAUTH_BASE_URL + 'token',
        body: {
            grant_type:    :refresh_token,
            client_id:     self.client_id,
            client_secret: self.client_secret,
            refresh_token: self.refresh_token,
            scope:         API_SCOPE,
        },
        verify: false,
    )

    if response.code == 200
      self.access_token = response.parsed_response['access_token']
      self.reset_expiration(response.parsed_response['expires_in'])
      self.save
    else
      false
    end
  end

  def fetch_app_code_url
    OAUTH_BASE_URL + "auth?scope=#{API_SCOPE}&response_type=code&access_type=offline&redirect_uri=#{redirect_uri}&client_id=#{client_id}"
  end

  def refresh_token_if_expired
    unless access_token_valid?
      refresh_access_token!
    end
  end

  def access_token_valid?
    self.expires_at.present? && self.expires_at > Time.now
  end

  def reset_expiration(duration)
    self.expires_at = Time.now + duration
  end
end