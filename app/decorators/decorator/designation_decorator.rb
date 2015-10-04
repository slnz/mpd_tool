module Decorator
  class DesignationDecorator < ApplicationDecorator
    def amount_raised
      donations.where(project: project).sum(:amount)
    end

    def name
      "#{first_name} #{last_name}".strip
    end

    def percentage_raised
      return 100 if goal == 0
      (amount_raised / goal * 100).to_i
    end

    def goal
      project.try(:goal) || amount_raised
    end
  end
end
