module Mpd
  class DoneesMailer < MpdMailer
    def welcome(donee)
      @donee = donee.decorate
      mail to: @donee.email, subject: 'Thanks for Signing up to track your MPD'
    end


    def new_donation(donee, donor, donation, designation, project)
      @donee = donee.decorate
      @donor = donor.decorate
      @donation = donation.decorate
      @designation = designation.decorate
      @project = project.try(:decorate)
      mail to: @donee.email, subject: "New Donation from #{@donor.name}"
    end

    def send_activation_code(donee)
      @donee = donee.decorate
      mail to: @donee.email, subject: 'Go Summer Project: Get Started with MPD'
    end
  end
end
