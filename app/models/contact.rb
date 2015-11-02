class Contact < ActiveRecord::Base
  has_many :donations, dependent: :destroy
  validates :code, uniqueness: true, allow_nil: true
  validates :name, presence: true
end
