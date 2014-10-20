class Project < ActiveRecord::Base
  validates :title, presence: true
  validates :code, presence: true
  has_many :donations
end
