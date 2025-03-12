module Import
  class DelegatedBaseBuilder
    include Callable
    include Import::Concerns::EntityBuildable

    def initialize(adapter_layer, facade, kind)
      @adapter_layer = adapter_layer
      @facade = facade
      @kind = kind
    end

    def call
      assign_foreign_attributes
      assign_foreign_bases
      assign_has_many_entities

      entity
    end

    private

    attr_reader :adapter_layer, :facade, :kind
    delegate_missing_to :adapter_layer

    def assign_foreign_bases
      reflections.delegated_base_associations.each do |association|
        adapter_layer.assign_delegate_base_to_delegated_base(association, entity, facade)
      end
    end

    def entity
      @entity ||= reflections.base_class.new(inherent_attributes)
    end

    def reflections
      @reflections ||= build_reflections_for(kind)
    end
  end
end
