source 'https://rubygems.org'
ruby "2.1.5"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
gem 'pg'
gem 'unicorn'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'foreman'
gem 'resque', :require => 'resque/server'
gem 'resque-web', require: 'resque_web'
gem 'resque_mailer'

gem 'chronic'
gem 'truncate_html'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'foundation-rails'
# Use jquery as the JavaScript library
gem 'jquery-ui-rails'
gem 'responders'

gem 'chartkick'
gem 'groupdate'

gem 'aws-ses'
gem 'exception_notification'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem "has_permalink"

gem 'draper'

gem 'fog', require: 'fog/aws'
gem 'carrierwave'

gem 'mini_magick'

gem 'ckeditor', :git => 'https://github.com/galetahub/ckeditor.git'
gem "font-awesome-rails"

gem 'omniauth'
gem "omniauth-google-oauth2"
gem 'omniauth-facebook'


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'spring'
  gem 'meta_request'
  gem 'web-console', '~> 2.0'
end

group :test, :darwin do
  gem 'rb-fsevent'
end

group :test do
  gem 'guard-rspec'
  gem 'growl'
  gem 'ruby-prof'
  gem 'capybara'
  gem 'launchy'
  gem 'resque_spec'
  gem 'rspec-activemodel-mocks'
  gem "factory_girl_rails", "~> 4.0"
  gem 'faker'
  gem 'rspec-rails'
  gem 'simplecov'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views


  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
end
