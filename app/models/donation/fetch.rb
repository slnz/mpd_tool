require 'csv'
class Donation
  class Fetch
    def self.from_dataserve
      Donation.where('created_at > ?', datefrom).destroy_all
      Pledge.where(status: Pledge.statuses['success']).each do |pledge|
        pledge.generate_donation
      end
      get(action: 'profiles').each do |profile|
        project = project(profile)
        get(profile: profile['PROFILE_CODE'],
            datefrom: datefrom.strftime('%m/%d/%y'),
            dateto: Date.tomorrow.strftime('%m/%d/%y'),
            action: 'gifts').each do |row|
          create_donation(row, project)
        end
      end
    end

    def self.datefrom
      return year_start + 4.months if (year_start + 4.months).past?
      year_start - 1.year + 4.months
    end

    def self.year_start
      Time.current.beginning_of_year
    end

    def self.get(params)
      process_csv RestClient.get(
        ENV['DATASERVE_URL'],
        params: params.merge(
          username: ENV['DATASERVE_USERNAME'],
          password: ENV['DATASERVE_PASSWORD']
        )
      )
    end

    def self.process_csv(data)
      CSV.parse(data.slice(data.index('"')..-1), headers: true)
    rescue ArgumentError
      []
    end

    def self.project(profile)
      Project.where(code: profile['PROFILE_CODE'])
        .first_or_create(title: profile['PROFILE_DESCRIPTION'])
    end

    def self.create_donation(data, project)
      destroy_online_donation(Donation.find_by(id: data['MEMO']))
      Donation.where(global_id: data['DONATION_ID']).first_or_create(
        project: project,
        contact: contact(data),
        designation_id: data['DESIGNATION'],
        amount: data['TENDERED_AMOUNT'],
        display_date: Date.strptime(data['DISPLAY_DATE'], '%m/%d/%Y'),
        payment_type: Donation.payment_types[data['PAYMENT_METHOD']]
      )
    end

    def self.destroy_online_donation(donation)
      return unless donation
      donation.pledge.complete!
    end

    def self.contact(data)
      Contact.where(code: nil, name: data['ACCT_NAME']).limit(1).update_all(code: data['PEOPLE_ID'])
      Contact.where(code: data['PEOPLE_ID']).first_or_create(name: data['ACCT_NAME'])
    end
  end
end
