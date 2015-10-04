class Pledge < ActiveRecord::Base
  belongs_to :designation
  validates :first_name, :last_name, :email, :phone, :address_line_1, :city, presence: true
  validates :amount, presence: true, unless: :prayer_only?

  validates :email, email: true
  validates :terms, acceptance: { accept: true }
end
