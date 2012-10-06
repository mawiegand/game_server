require "bundler/capistrano"

set :stages, %w(production staging)
set :default_stage, "staging"

require "capistrano/ext/multistage"

`ssh-add`

default_run_options[:pty] = true                  # problem with ubuntu
set :ssh_options, :forward_agent => true          # ssh forwarding
set :port, 5775

set :application, "game server"
set :repository,  "git@github.com:wackadoo/game_server.git"
set :branch,      "staging"

set :scm, :git

set :user, "deploy-gs"
set :use_sudo, false

set :deploy_to, "/var/www/game_server"
set :deploy_via, :remote_cache

desc "Print server name"
task :uname do
  run "uname -a"
end

namespace :deploy do
  desc "Restart Thin"
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
    restart_ticker
  end

  desc "Reset DB"
  task :reset do
    exit
    # run "cd #{current_path}; bundle exec rake RAILS_ENV=\"#{stage}\" db:reset"
    # restart
  end

  desc "Start Thin"
  task :start do
    run "cd #{current_path}; bundle exec thin -C config/thin_#{stage}.yml start"
  end

  desc "Stop Thin"
  task :stop do
    run "cd #{current_path}; bundle exec thin -C config/thin_#{stage}.yml stop"
  end

  desc "Restart Ticker"
  task :restart_ticker do
    stop_ticker
    start_ticker
  end

  desc "Start Ticker"
  task :start_ticker do
    run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/ticker start"
  end

  desc "Stop Ticker"
  task :stop_ticker do
    run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/ticker stop"
  end
  
  desc "Check Consistency"
  task :check_consistency do
    run "cd #{current_path}; RAILS_ENV=#{stage} bundle exec script/repair_consistency"
  end
end
