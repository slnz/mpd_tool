class DesignationMailer < ApplicationMailer
  def send_activation_code(designation)
    @user = designation
    @designation = designation
    mail to: designation.email,
         subject: 'Go Summer Project: Get Started with MPD'
  end
end
