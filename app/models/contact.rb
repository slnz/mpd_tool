class Contact < ActiveRecord::Base
  has_many :donations
  validates :code, uniqueness: { scope: :designation_code }
  validates :name, presence: true
end
