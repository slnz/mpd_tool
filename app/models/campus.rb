class Campus < ActiveRecord::Base
  has_many :designations, dependent: :nullify
  validates :name, presence: true
end
