source 'http://rubygems.org'

gem 'rails', '3.1.12'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'capistrano', '~> 2.14.0'
gem 'thin'
gem 'httparty',    '~> 0.13'
#gem 'rb-readline', '0.4.2'	
gem 'gravatar_image_tag'

gem 'highline', '>= 1.6.12'


gem 'simplecov',      :require => false, :group => :test
gem 'simplecov-rcov', :require => false, :group => :test

gem 'xmpp4r'
gem 'xmpp4r-simple', '>= 0.3.2', :git => "git@github.com:blaine/xmpp4r-simple.git"
gem 'jabber-bot'

gem 'sampl', '~> 0.0.2'     # PSIORI event tracking


group :production do
  gem 'pg'
	gem 'awe_native_extensions', '>= 0.0.16', :git => "git@github.com:wackadoo/awe_native_extensions.git"
end

group :ticker_development do
  gem 'pg'
	gem 'awe_native_extensions', '>= 0.0.16', :git => "git@github.com:wackadoo/awe_native_extensions.git"
end

group :development do
  gem 'rails-erd'
# gem 'rails-dev-tweaks', '~> 0.6.1'
end

gem 'therubyracer', '>= 0.11.0'          # missing javascript runtime
gem 'libv8', '~> 3.16.14.7'

gem 'will_paginate'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'ci_reporter', '~> 1.9.0'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem 'test-unit', '~> 2.0.0'
end

gem 'jquery-ui-rails'

gem 'rails3-jquery-autocomplete', git: 'https://github.com/francisd/rails3-jquery-autocomplete'



