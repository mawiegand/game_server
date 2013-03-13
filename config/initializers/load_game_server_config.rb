puts           "#{Rails.root}/config/game_server.yml"

GAME_SERVER_CONFIG = YAML.load_file("#{Rails.root}/config/game_server.yml")[Rails.env]