class Subscription < ActiveRecord::Base
  belongs_to :project
  belongs_to :donor, class_name: 'User::Donor'
  belongs_to :designation
  validates :project, :donor, :designation, presence: true
end
