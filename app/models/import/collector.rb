module Import
  class Collector
    def initialize(session, facade:)
      @session = session
      @facade = facade
    end

    attr_reader :session, :facade

    delegate :model_class, to: :facade

    def properties
      @properties ||= session.build_properties(model_class)
    end

    def call
      find || buffer && nil
    end

    def find
      finder = session.build_finder(facade)
      finder.call
    end

    def buffer
      collect_belongs_to
      collect_has_many_associations
      collect_has_and_belongs_to_many_associations
    end

    def collect_belongs_to
      associations = properties.belongs_to_associations

      associations.each do |association|
        # ???
      end
    end

    def collect_has_many_associations
      properties.has_many_associations.each do |association|
        facade_list = facade.send association.name
        # collector_list = session.build_collector_list(facade_list)
        collector_list = facade_list.to_collectors
        # debugger
        collector_list.each(&:call)
      end
    end

    def collect_has_and_belongs_to_many_associations
    end
  end
end
