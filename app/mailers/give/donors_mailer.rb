module Give
  class DonorsMailer < GiveMailer
    def welcome(donor)
      @donor = donor.try(:decorate)
      mail to: donor.email, subject: 'Thanks for partnering with Summer Projects'
    end

    def thanks_for_pledge(pledge)
      @donee = pledge.donee.decorate
      @donor = pledge.donor.decorate
      @pledge = pledge.decorate
      mail to: donor.email, subject: 'Thanks for partnering with Summer Projects'
    end
  end
end
