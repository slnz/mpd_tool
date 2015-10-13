class User
  class Donee < ActiveType::Record[User]
    validates :first_name, :last_name, :email, :phone, :address_line_1, :city, presence: true, if: :active?
    validates :email, email: true, if: :active?
    validates :terms, acceptance: { accept: true }, if: :active?
    validates :uid, presence: true
    validates :provider, presence: true
    validates :email, presence: true
    validate :check_activation_code

    has_one :designation, dependent: :nullify
    has_many :donations, through: :designation
    has_many :projects, through: :donations
    enum donee_state: { setup: 0, active: 1 }
    after_update :send_welcome_notification, if: -> { donee_state_changed? && active? }

    def send_welcome_notification
      Mpd::DoneesMailer.welcome(self).deliver_now
    end

    def check_activation_code
      return unless activation_code
      return if designation
      errors.add(:activation_code, 'is not valid') unless designation
    end

    def activation_code=(activation_code)
      self.designation =
        Designation.find_by(activation_code: activation_code.upcase)
      super activation_code.upcase
    end

    def image
      super.try(:gsub!, 'http://', 'https://')
    end

    def large_image
      "#{image}?width=160&height=160"
    end
  end
end
