# frozen_string_literal: true

module Draper
  module Decoratable
    module ClassMethods
      def decorator_class
        prefix = respond_to?(:model_name) ? model_name : name
        decorator_name = "Decorator::#{prefix}Decorator"
        decorator_name.constantize
      rescue NameError => error
        if superclass.respond_to?(:decorator_class)
          superclass.decorator_class
        else
          raise unless error.missing_name?(decorator_name)
          raise Draper::UninferrableDecoratorError
        end
      end
    end
  end
end
