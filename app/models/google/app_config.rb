class Google::AppConfig < ActiveRecord::Base

  def self.the_app_config
    Google::AppConfig.find(1)
  end

  def app_code_url
    "https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/androidpublisher&response_type=code&access_type=offline&redirect_uri=#{redirect_uri}&client_id=#{client_id}"
  end

  def reset_expiration(duration)
    self.expires_at = Time.now + duration
  end
end