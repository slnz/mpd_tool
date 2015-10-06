class Pledge < ActiveRecord::Base
  belongs_to :designation
  belongs_to :donor, class_name: 'User::Donor'
  validates :donor, presence: true
  validates :amount, :giving_method, presence: true, unless: :prayer_only?
  validates :donor_id,
            uniqueness: { scope: :designation_id, message: '- you are already praying for this person' },
            if: :prayer_only?
  enum status: { 'pending' => 0, 'success' => 1, 'failure' => 2 }
  enum giving_method: { 'credit card' => 0, 'internet banking' => 1 }

  def create_request(options = {})
    Pledge::Request.create(options.merge(pledge: self))
  end

  def create_response(options = {})
    Pledge::Response.create(options.merge(pledge: self))
  end
end
