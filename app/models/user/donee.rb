class User
  class Donee < ActiveType::Record[User]
    validates :uid, presence: true
    validates :provider, presence: true
    validates :email, presence: true
    validate :check_activation_code

    has_one :designation, dependent: :nullify
    has_many :donations, through: :designation
    has_many :projects, through: :donations

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

    def give_url
      "#{ENV['GIVE_URL']}/#{slug}"
    end

    def image
      super.try(:gsub!, 'http://', 'https://')
    end

    def large_image
      "#{image}?width=160&height=160"
    end
  end
end
