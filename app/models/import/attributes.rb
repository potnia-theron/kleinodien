module Import
  class Attributes
    def initialize(session, facade:, properties:)
      @session = session

      @facade = facade
      @properties = properties
    end

    def call(&block)
      attributes.merge(belongs_to_attributes(block))
    end

    private

    attr_reader :facade, :properties, :session
    delegate :attribute_getter_names, to: :properties
    delegate :belongs_to_attribute_getter_names, to: :properties

    def attributes
      attribute_getter_names.transform_values { |getter_name| facade.send(getter_name) }
    end

    def belongs_to_attributes
      belongs_to_attribute_getter_names.transform_values { |getter_name| facade.send(getter_name) }
    end
  end
end
