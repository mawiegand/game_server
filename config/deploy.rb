require "bundler/capistrano"

`ssh-add`

default_run_options[:pty] = true                  # problem with ubuntu
set :ssh_options, :forward_agent => true          # ssh forwarding
set :port, 5775

set :application, "game server"
set :repository,  "git@github.com:wackadoo/game_server.git"

set :scm, :git

set :user, "deploy-gs"
set :use_sudo, false

set :deploy_to, "/var/www/game_server"
set :deploy_via, :remote_cache

role :web, "test1.wack-a-doo.de"                          # Your HTTP server, Apache/etc
role :app, "test1.wack-a-doo.de"                          # This may be the same as your `Web` server
role :db,  "test1.wack-a-doo.de", :primary => true        # This is where Rails migrations will run

namespace :deploy do
  desc "Restart Thin"
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
    restart_ticker
  end

  desc "Reset DB"
  task :reset do
    run "cd #{current_path}; bundle exec rake RAILS_ENV=\"production\" db:reset"
    restart
  end

  desc "Start Thin"
  task :start do
    run "cd #{current_path}; bundle exec thin -C config/thin_server.yml start"
  end

  desc "Stop Thin"
  task :stop do
    run "cd #{current_path}; bundle exec thin -C config/thin_server.yml stop"
  end

  desc "Restart Ticker"
  task :restart_ticker do
    stop_ticker
    start_ticker
  end

  desc "Start Ticker"
  task :start_ticker do
    run "cd #{current_path}; RAILS_ENV=production bundle exec script/ticker start"
  end

  desc "Stop Ticker"
  task :stop_ticker do
    run "cd #{current_path}; RAILS_ENV=production bundle exec script/ticker stop"
  end
end
