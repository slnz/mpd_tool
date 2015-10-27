module Decorator
  class PledgeDecorator < ApplicationDecorator
    decorates_association :designation
    decorates_association :donor
    def code
      designation.try(:designation_code)
    end

    def donor_name
      donor.try(:name)
    end

    def donor_address
      donor.try(:address)
    end

    def donee_name
      designation.try(:name)
    end

    def giving_method
      object.giving_method.try(:titleize)
    end

    def display_date
      created_at.strftime('%m/%d/%Y')
    end

    def donor_wise_payment_type
      return 'CREDITCARD' if object.giving_method == 'credit card'
      'AP'
    end
  end
end
