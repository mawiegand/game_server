role :web,       'test2.wack-a-doo.de'                          # Your HTTP server, Apache/etc
role :app,       'test2.wack-a-doo.de'                          # This may be the same as your `Web` server
role :db,        'test2.wack-a-doo.de', :primary => true        # This is where Rails migrations will run

set :port,       22

set :rails_env,  'staging_test'

set :branch,     'staging-test'

set :deploy_to,  '/var/www/game_server_staging_test'
