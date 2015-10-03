class User < ActiveRecord::Base
  has_permalink :name
  devise :omniauthable, omniauth_providers: [:facebook]

  validates :uid, presence: true
  validates :provider, presence: true
  validates :email, presence: true
  validate :check_activation_code

  has_one :designation, dependent: :nullify
  has_many :donations, through: :designation
  has_many :projects, through: :donations

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create(
      email: auth[:info][:email],
      first_name: auth[:info][:first_name],
      last_name: auth[:info][:last_name],
      image: auth[:info][:image]
    )
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

  def name
    "#{first_name} #{last_name}".strip
  end
end
