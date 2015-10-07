class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :omniauthable, omniauth_providers: [:facebook]
  validates :email, uniqueness: true, presence: true

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create(
      email: auth[:info][:email],
      first_name: auth[:info][:first_name],
      last_name: auth[:info][:last_name],
      image: auth[:info][:image]
    )
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def reference_name
    "#{first_name[0]} #{last_name}".strip.upcase
  end
end
