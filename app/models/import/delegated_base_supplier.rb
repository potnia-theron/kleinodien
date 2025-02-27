module Import
  class DelegatedBaseSupplier
    include Concerns::RecordBuildable

    def initialize(adapter_layer, facade, delegated_type_reflections)
      @adapter_layer = adapter_layer
      @facade = facade
      @delegated_type_reflections = delegated_type_reflections
    end

    def supply_delegated_base
      find || build
    end

    private

    attr_reader :adapter_layer, :facade, :delegated_type_reflections
    delegate :delegated_base_class, to: :delegated_type_reflections
    delegate_missing_to :adapter_layer

    def find
      # TODO: do we really need to lookup for a delegated_base?
      # finder_class.new(order, facade: facade).find
    end

    def finder_class
      @finder_class ||= "Import::#{delegated_base_class.name}Finder".constantize
    end

    def build
      assign_foreign_attributes
      assign_foreign_bases
      build_has_many_records

      record
    end

    def record
      @record ||= delegated_base_class.new(inherent_attributes)
    end

    def reflections
      build_reflections_for delegated_base_class
    end
  end
end
