class Pledge < ActiveRecord::Base
  belongs_to :designation
  belongs_to :donation
  belongs_to :project
  belongs_to :contact
  belongs_to :donor, class_name: 'User::Donor'
  enum status: { 'pending' => 0, 'success' => 1, 'failure' => 2, 'complete' => 3 }
  enum giving_method: { 'credit card' => 0, 'internet banking' => 1 }
  validates :donor, :project, :amount, :giving_method, presence: true
  validates :donation, :contact, presence: true, if: :success?
  validates :amount, format: { with: /\A\d+[\.0]*\Z/i, message: 'can only be whole dollars' }
  before_validation :generate_contact, :generate_donation, if: :success?
  before_destroy :destroy_donation
  delegate :donee, to: :designation
  after_update :send_notifications, if: -> { status_changed? && success? }
  serialize :payload
  serialize :params

  def send_notifications
    Mpd::DoneesMailer.new_donation(donee, donor, donation, designation, project).deliver_now
    Give::DonorsMailer.new_donation(donee, donor, donation, designation, project).deliver_now
  end

  def generate_contact
    self.contact ||= Contact.create_with(code: id).find_or_create_by(
      name: "#{donor.last_name}, #{donor.first_name}"
    )
  end

  def generate_donation
    self.donation ||= Donation.create(
      project: project,
      contact: contact,
      designation_id: designation.designation_code,
      amount: amount,
      display_date: Time.current,
      payment_type: giving_method == 'credit card' ? 'CREDITCARD' : 'AP',
      gift_type: Donation.gift_types[:online]
    )
  end

  def create_request(options = {})
    Pledge::Request.create(options.merge(pledge: self))
  end

  def create_response(options = {})
    Pledge::Response.create(options.merge(pledge: self))
  end

  def create_subscription
    return unless newsletter?
    Subscription.find_or_create_by(donor: donor, designation: designation, project: designation.project)
  end

  protected

  def destroy_donation
    donation.try(:destroy)
  end
end
