class Deposit < ActiveRecord::Base
  belongs_to :designation
  belongs_to :project
  enum status: { 'pending' => 0, 'complete' => 1 }
  enum giving_method: { 'cash' => 0, 'cheque' => 1 }
  validates :first_name, :last_name, :amount, :giving_method, :designation, :project, presence: true
  validate :amount_not_changed_when_complete, :giving_method_not_changed_when_complete
  before_validation :set_project, on: :create

  def reference_name
    "#{first_name[0]} #{last_name}".strip.upcase
  end

  protected

  def amount_not_changed_when_complete
    return unless amount_changed? && complete?
    errors.add(:amount, "can't be updated after deposit completed")
  end

  def giving_method_not_changed_when_complete
    return unless giving_method_changed? && complete?
    errors.add(:giving_method, "can't be updated after deposit completed")
  end

  def set_project
    self.project ||= designation.try(:project)
  end
end
