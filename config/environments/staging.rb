# frozen_string_literal: true

require_relative 'production'

Rails.application.configure do
  config.action_mailer.default_url_options =
    { host: 'stage.mpd.studentlife.org.nz' }

  config.action_controller.asset_host = 'http://stage.mpd.studentlife.org.nz'
  config.action_mailer.asset_host = config.action_controller.asset_host

  Mail.register_interceptor RecipientInterceptor.new(ENV['EMAIL_RECIPIENTS'],
                                                     subject_prefix: '[STAGE]')
end
