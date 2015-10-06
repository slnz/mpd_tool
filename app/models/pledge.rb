class Pledge < ActiveRecord::Base
  belongs_to :designation
  belongs_to :project
  belongs_to :donor, class_name: 'User::Donor'
  validates :donor, :project, :amount, :giving_method, presence: true
  enum status: { 'pending' => 0, 'success' => 1, 'failure' => 2 }
  enum giving_method: { 'credit card' => 0, 'internet banking' => 1 }

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
end
