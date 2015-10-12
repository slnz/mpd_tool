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

    def donee_name
      designation.try(:name)
    end

    def giving_method
      object.giving_method.try(:titleize)
    end
  end
end
