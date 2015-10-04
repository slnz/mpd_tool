class Project < ActiveRecord::Base
  validates :title, presence: true
  validates :code, presence: true
  has_many :donations
  has_many :designations
  has_many :donees, through: :designations, class_name: 'User::Donee'

  def description_with_name(name)
    description.try(:gsub!, '%{name}', name) || ''
  end

  def days_until
    ((date || Time.current.to_date) - Time.current.to_date).to_i
  end
end
