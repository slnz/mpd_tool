# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :omniauthable, omniauth_providers: [:facebook]
  validates :email, uniqueness: true
  validates :email, presence: true, unless: :uid
  before_validation :set_name

  def set_name
    self.name = "#{first_name} #{last_name}".strip
  end

  def reference_name
    "#{first_name[0]} #{last_name}".strip.upcase
  end

  def self.from_omniauth(auth)
    where('(provider = ? AND uid = ?) OR email = ?',
          auth[:provider],
          auth[:uid],
          auth[:info][:email] || "#{auth[:uid]}@#{auth[:provider]}.com")
      .first_or_initialize.assign_omniauth_attributes(auth)
  end

  def assign_omniauth_attributes(auth)
    assign_new_omniauth_attributes(auth) if new_record?
    assign_new_and_existing_omniauth_attributes(auth)
    save
    self
  end

  protected

  def assign_new_omniauth_attributes(auth)
    assign_attributes(
      first_name: auth[:info][:first_name],
      last_name: auth[:info][:last_name],
      email: auth[:info][:email] || "#{auth[:uid]}@#{auth[:provider]}.com",
      password: Devise.friendly_token[0, 20],
      image: auth[:info][:image]
    )
  end

  def assign_new_and_existing_omniauth_attributes(auth)
    assign_attributes(
      provider: auth[:provider],
      uid: auth[:uid]
    )
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
