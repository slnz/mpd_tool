# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'projects@studentlife.org.nz'
  layout 'mailer'
end
