# frozen_string_literal: true

module Decorator
  class DesignationDecorator < ApplicationDecorator
    decorates_association :project

    def amount_raised
      donations.where(project: project).sum(:amount) + deposits.completed.where(project: project).sum(:amount)
    end

    def amount_deposited
      deposits.pending.where(project: project).sum(:amount)
    end

    def name
      "#{first_name} #{last_name}".strip
    end

    def percentage_raised
      return 100 if goal.zero?
      percentage = (amount_raised / goal * 100).to_i
      percentage
    end

    def percentage_deposited
      return 0 if goal.zero?
      percentage = (amount_deposited / goal * 100).to_i
      return 100 - percentage_raised if percentage_raised + percentage > 100
      percentage
    end

    def goal
      project.try(:goal) || amount_raised
    end

    def amount_raised_and_deposited
      amount_raised + amount_deposited
    end

    def percentage_raised_and_deposited
      percentage_raised + percentage_deposited
    end

    def donor_count
      donations.count + deposits.count
    end
  end
end
