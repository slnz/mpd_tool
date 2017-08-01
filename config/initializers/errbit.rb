# frozen_string_literal: true

if Rails.env.production? && ENV['errbit_key']
  Airbrake.configure do |config|
    config.api_key = ENV['errbit_key']
    config.host    = 'errors.studentlife.org.nz'
    config.port    = 80
  end
end
