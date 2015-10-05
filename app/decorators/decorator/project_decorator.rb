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
  end
end
