class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true
  validates :code, presence: true
  has_many :donations
  has_many :designations
  has_many :donees, through: :designations, class_name: 'User::Donee'
  scope :opened, -> { where('date >= ?', Time.current) }

  def opened?
    return false unless date
    date >= Time.current
  end
end
