class Project < ActiveRecord::Base
  validates :title, presence: true
  validates :code, presence: true
  has_many :donations
  has_many :designations
  has_many :donees, through: :designations, class_name: 'User::Donee'
end
