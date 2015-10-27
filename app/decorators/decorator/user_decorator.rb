module Decorator
  class UserDecorator < ApplicationDecorator
    def address
      "#{address_line_1}\n#{address_line_2}\n#{city} #{postcode}"
    end
  end
end
