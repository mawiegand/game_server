source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'capistrano', '>= 2.12.0'
gem 'thin'
gem 'httparty'
gem 'rb-readline'	
gem 'gravatar_image_tag'

gem 'xmpp4r'


gem 'simplecov',      :require => false, :group => :test
gem 'simplecov-rcov', :require => false, :group => :test

group :production do
  gem 'pg'
	gem 'awe_native_extensions', '>= 0.0.15', :git => "git@github.com:wackadoo/awe_native_extensions.git"
end

group :ticker_development do
  gem 'pg'
	gem 'awe_native_extensions', '>= 0.0.15', :git => "git@github.com:wackadoo/awe_native_extensions.git"
end

group :development do
  gem 'rails-erd'
end

gem 'therubyracer'          # missing javascript runtime

gem 'will_paginate'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# make api requests within rails
gem 'httparty'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'ci_reporter'


group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem 'test-unit', '~> 2.0.0'
end
