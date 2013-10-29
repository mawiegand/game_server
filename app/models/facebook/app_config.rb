class Facebook::AppConfig < ActiveRecord::Base

  def self.the_app_config
    Facebook::AppConfig.find(1)
  end
end
