class DesignationMailer < ActionMailer::Base
  default from: 'projects@studentlife.org.nz'

  def send_activation_code(designation)
    @designation = designation
    mail to: designation.email,
         subject: 'Go Summer Project: Get Started with MPD'
  end
end
