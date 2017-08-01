# frozen_string_literal: true

module Decorator
  class DepositDecorator < ApplicationDecorator
    decorates_association :designation

    def giving_method
      object.giving_method.try(:titleize)
    end

    def display_date
      created_at.strftime('%m/%d/%Y')
    end

    def name
      "#{first_name} #{last_name}".strip
    end

    def title
      "Deposit ##{id} - #{reference_name}"
    end

    def code
      "#{deposit.id}-#{designation.designation_code}"
    end
  end
end
