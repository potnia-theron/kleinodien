module Import
  class CollectAction
    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :facade, :session

    def call
      find || continue
    end

    private

    delegate :model_class, to: :facade

    def continue
      record
      has_many_associations
      has_and_belongs_to_many_associations
    end

    def find
      session.build_finder(facade).call
    end

    def has_and_belongs_to_many_associations
    end

    def has_many_associations
    end

    def properties
      @session.build_properties(model_class)
    end

    def record
      properties.attribute_names.index_with { |attr_name| facade.send(attr_name) }
    end
  end
end
