class Donation < ActiveRecord::Base
  paginates_per 50
  default_scope do
    order('display_date desc')
      .where('display_date > ?', Time.zone.now.beginning_of_year)
  end
  scope :project, -> project { where(project: project) }
  enum payment_type: { 'STAFF' => 0,
                       'TRANSFER' => 1,
                       'CASH' => 2,
                       'CHEQUE' => 3,
                       'CREDITCARD' => 4,
                       'BT' => 5,
                       'FLOW-THRU' => 6,
                       'AMEX' => 7,
                       'AP' => 8 }
  validates :global_id, presence: true, uniqueness: true, unless: lambda { |o| o.payment_type == 'STAFF' }
  validates :project, :display_date, :amount, :designation_id, :contact, presence: true
  belongs_to :project
  belongs_to :contact
  belongs_to :designation, foreign_key: :designation_code
  delegate :name, to: :contact
end
