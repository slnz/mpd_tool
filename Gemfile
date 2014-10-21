source 'https://rubygems.org'

ruby '2.1.2'

gem 'airbrake'
gem 'coffee-rails'
gem 'delayed_job_active_record'
gem 'email_validator'
gem 'flutie'
gem 'high_voltage'
gem 'i18n-tasks'
gem 'jquery-rails'
gem 'normalize-rails', '~> 3.0.0'
gem 'pg'
gem 'rack-timeout'
gem 'rails', '4.1.6'
gem 'recipient_interceptor'
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'simple_form'
gem 'title'
gem 'uglifier'
gem 'puma'
gem 'devise'
gem 'omniauth-facebook'
gem 'haml'
gem 'font-awesome-rails'
gem 'rest-client'
gem 'activeadmin', github: 'activeadmin'
gem 'active_admin_import' , '2.1.1'
gem 'active_skin'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'ransack'
gem 'has_scope'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-spring'
  gem 'guard-puma'
  gem 'travis'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'letter_opener_web'
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'rubocop'
end

group :test do
  gem 'capybara-webkit', '>= 1.2.0'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'vcr'
  gem 'webmock'
  gem 'timecop'
  gem 'fuubar'
  gem 'faker'
  gem 'codeclimate-test-reporter', require: nil
end

group :staging, :production do
  gem 'rails_12factor'
  gem 'airbrake'
  gem 'newrelic_rpm'
end
