module Import
  class BaseAction
    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session
    delegate :attribute_getter_names, to: :properties
    delegate :belongs_to_facade_getter_names, to: :properties
    delegate :model_class, to: :facade

    def call
      find || continue
    end

    def continue
      ordinary_attributes
      foreign_attributes
      has_many_associations
      has_and_belongs_to_many_associations
    end

    def find
      session.build_finder(facade).call
    end

    def foreign_attributes
      belongs_to_facade_getter_names.transform_values { |getter_name| facade.send(getter_name) }
    end

    def has_and_belongs_to_many_associations
    end

    def has_many_associations
    end

    def ordinary_attributes
      attribute_getter_names.transform_values { |getter_name| facade.send(getter_name) }
    end

    def properties
      @session.build_properties(model_class)
    end
  end
end
