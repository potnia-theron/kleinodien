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

    # TODO: extract class Import::CollectBelongsToAssociation
    def collect_belongs_to
      properties.belongs_to_associations { |association| facade.send(association.name) }
    end

    # TODO: extract class Import::CollectHasManyAssociation
    def collect_has_many_associations
      properties.has_many_associations.each do |association|
        association_name = association.name
        collectors = facade.send(association_name).to_collectors
        collectors.each(&:call)
      end
    end

    def collect_has_and_belongs_to_many_associations
    end
  end
end
