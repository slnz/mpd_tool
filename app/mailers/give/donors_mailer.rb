# frozen_string_literal: true

module Give
  class DonorsMailer < GiveMailer
    def welcome(donor)
      @donor = donor.try(:decorate)
      mail to: donor.email, subject: 'Thanks for partnering with Summer Projects'
    end

    def new_donation(donee, donor, donation, designation, project)
      @donee = donee.decorate
      @donor = donor.decorate
      @donation = donation.decorate
      @designation = designation.decorate
      @project = project.try(:decorate)
      mail to: @donor.email, subject: "Thanks for your donation to #{@donee.first_name}"
    end
  end
end
