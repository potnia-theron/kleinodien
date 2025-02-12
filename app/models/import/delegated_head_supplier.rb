module Import
  class DelegatedHeadSupplier
    include Concerns::RecordBuildable

    def initialize(adapter_layer, facade, delegated_type_reflections)
      @adapter_layer = adapter_layer
      @facade = facade
      @delegated_type_reflections = delegated_type_reflections
    end

    def supply_delegated_head
      find || build
    end

    private

    attr_reader :adapter_layer, :facade, :delegated_type_reflections
    delegate :head_class, to: :delegated_type_reflections
    delegate_missing_to :adapter_layer

    def find
      # TODO: do we really need to lookup for a delegated_head?
      finder_class.new(order, facade: facade).find
    end

    def finder_class
      @finder_class ||= "Import::#{head_class.name}Finder".constantize
    end

    def build
      build_has_many_records
      assign_foreign_attributes

      record
    end

    def record
      @record ||= head_class.new(inherent_attributes)
    end

    def reflections
      build_reflections_for head_class
    end
  end
end
