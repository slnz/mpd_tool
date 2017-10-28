# frozen_string_literal: true

class Pledge < ApplicationRecord
  belongs_to :designation
  belongs_to :project
  belongs_to :contact
  belongs_to :donor, class_name: 'User::Donor'
  belongs_to :donee, class_name: 'User::Donee'
  enum status: { 'pending' => 0, 'success' => 1, 'failure' => 2, 'complete' => 3 }
  enum giving_method: { 'credit card' => 0, 'internet banking' => 1 }
  validates :donor, :project, :amount, :giving_method, presence: true
  validates :donation, :contact, presence: true, if: :success?
  validates :amount, format: { with: /\A\d+[\.0]*\Z/i, message: 'can only be whole dollars' }
  before_validation :generate_contact, :generate_donation, if: :success?
  delegate :donee, to: :designation
  has_one :donation, dependent: :destroy
  after_update :send_notifications, if: -> { status_changed? && success? }
  serialize :payload
  serialize :params

  def send_notifications
    Mpd::DoneesMailer.new_donation(donee, donor, donation, designation, project).deliver_now
    Give::DonorsMailer.new_donation(donee, donor, donation, designation, project).deliver_now
  end

  def generate_contact
    self.contact ||= Contact.find_or_create_by(name: "#{donor.last_name}, #{donor.first_name}")
  end

  def generate_donation
    Donation.find_or_create_by(pledge: self) do |donation|
      donation.project = project
      donation.contact = contact
      donation.designation_id = designation.designation_code
      donation.amount = amount
      donation.display_date = created_at
      donation.payment_type = giving_method == 'credit card' ? 'CREDITCARD' : 'AP'
      donation.gift_type = Donation.gift_types[:online]
    end
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  def create_request(options = {})
    Pledge::Request.create(options.merge(pledge: self))
  end

  def create_response(params = nil)
    update(params: params) if params
    Pledge::Response.create(pledge: self)
  end

  def create_subscription
    return unless newsletter?
    Subscription.find_or_create_by(donor: donor, designation: designation, project: designation.project)
  end
end
