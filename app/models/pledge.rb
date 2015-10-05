class Pledge < ActiveRecord::Base
  belongs_to :designation
  belongs_to :donor, class_name: 'User::Donor'
  validates :donor, presence: true
  validates :amount, presence: true, unless: :prayer_only?
  validates :donor_id,
            uniqueness: { scope: :designation_id, message: '- you are already praying for this person' },
            if: :prayer_only?
end
