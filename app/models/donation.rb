class Donation < ActiveRecord::Base
  paginates_per 50
  default_scope do
    order('display_date desc')
      .where('display_date > ?', Time.now.beginning_of_year)
  end
  scope :project, -> project { where(project: project) }
  validates :global_id, presence: true, uniqueness: true
  validates :contact_id, presence: true
  validates :designation_id, presence: true
  validates :amount, presence: true
  validates :display_date, presence: true
  validates :project, presence: true

  belongs_to :project
  belongs_to :contact

  delegate :name, to: :contact
end
