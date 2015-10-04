module Decorator
  class ApplicationDecorator < Draper::Decorator
    delegate_all
    def self.collection_decorator_class
      PaginationDecorator
    end

    def self.object_class
      @object_module ||= inferred_object_class
    end

    def self.inferred_object_class
      name = object_class_name
      name.slice! 'Decorator::'
      name.constantize
    rescue NameError => error
      raise if name && !error.missing_name?(name)
      raise Draper::UninferrableSourceError.new(self), 'Not Found'
    end
  end
end
