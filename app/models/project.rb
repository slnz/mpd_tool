class Project < ActiveRecord::Base
  validates :title, presence: true
  validates :code, presence: true
  has_many :donations
  has_many :designations
  has_many :users, through: :designations

  def description_with_name(name)
    description.try(:gsub!, '%{name}', name) || ''
  end
end
