class User
  class Donor < ActiveType::Record[User]
    validates :first_name, :last_name, :email, :phone, :address_line_1, :city, presence: true, if: :active?
    validates :email, email: true, if: :active?
    validates :terms, acceptance: { accept: true }, if: :active?
    enum donor_state: { setup: 0, active: 1 }
    has_many :pledges
    has_many :subscriptions, dependent: :destroy
    after_update :send_welcome_notification, if: -> { donor_state_changed? && active? }

    def send_welcome_notification
      Give::DonorsMailer.welcome(self).deliver_now
    end

    def self.to_csv
      attributes = %w{first_name last_name email facebook_profile}

      CSV.generate(headers: true) do |csv|
        csv << attributes

        all.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end

    def facebook_profile
      "https://facebook.com/#{uid}" if uid
    end
  end
end
