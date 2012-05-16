source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'capistrano'
gem 'thin'



group :production do
  gem 'pg'
	gem 'awe_native_extensions', :git => "git@github.com:wackadoo/awe_native_extensions.git"
end

group :ticker_development do
  gem 'pg'
#	gem 'awe_native_extensions', :path => '/usr/lib/ruby/gems/1.9.1/gems/awe_native_extensions-0.0.1/'
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

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end
