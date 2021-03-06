# frozen_string_literal: true

class Designation < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :designation_code, presence: true
  validates :email, presence: true, uniqueness: true
  validates :activation_code, presence: true
  before_validation :generate_activation_code, on: :create
  after_create :send_activation_code
  belongs_to :donee, class_name: 'User::Donee'
  belongs_to :campus
  belongs_to :project
  has_many :donations, primary_key: :designation_code
  has_many :pledges, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :deposits, dependent: :destroy

  def send_activation_code
    generate_activation_code unless activation_code
    Mpd::DoneesMailer.send_activation_code(self).deliver_now
    self.email_sent = true
    save
  end

  def project
    super.try(:opened?) ? super : nil
  end

  protected

  def generate_activation_code
    loop do
      self.activation_code = SecureRandom.hex.upcase[0, 5]
      break unless Designation.find_by(activation_code: activation_code)
    end
  end
end
