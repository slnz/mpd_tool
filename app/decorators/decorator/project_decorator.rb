module Decorator
  class ProjectDecorator < ApplicationDecorator
    def name
      "#{title} #{Time.current.year}"
    end

    def description_with_name(name)
      description.try(:gsub!, '%{name}', name) || ''
    end

    def days_until
      ((date || Time.current.to_date) - Time.current.to_date).to_i
    end

    def amount_raised
      donations.sum(:amount)
    end

    def percentage_raised
      return 100 if total_goal == 0
      (amount_raised / total_goal * 100).to_i
    end

    def total_goal
      (object.goal * designations.count) || amount_raised
    end
  end
end
