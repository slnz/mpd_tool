module Mpd
  class DoneesMailer < MpdMailer
    def welcome(donee)
      @donee = donee.decorate
      mail to: @donee.email, subject: 'Thanks for Signing up to track your MPD'
    end

    def notify_of_new_pledge(pledge)
      @donee = pledge.donee.decorate
      @donor = pledge.donor.decorate
      @pledge = pledge.decorate
      mail to: donee.email, subject: "New Donation from #{@donor.name}"
    end

    def send_activation_code(donee)
      @donee = donee.decorate
      mail to: @donee.email, subject: 'Go Summer Project: Get Started with MPD'
    end
  end
end
