module LayeredImport
  class DelegatedRecordBuilder
    def self.build_delegated_record(...) = new(...).build_delegated_record

    def initialize(adapter_layer, facade, kind)
      @adapter_layer = adapter_layer
      @facade = facade
      @kind = kind
    end

    attr_reader :adapter_layer, :facade, :kind

    def build_delegated_record
      build_has_many_records
      assign_foreign_attributes
      record
    end

    def build_has_many_records
      reflections.has_many_associations.map do |association|
        create_has_many_builder(association, facade, record).build_many
      end
    end

    def inherent_attributes
      reflections.inherent_attribute_names.index_with { |attr| facade.send(attr) }.compact
    end

    def assign_foreign_attributes
      reflections.belong_to_associations.each do |association|
        adapter_layer.create_foreign_attribute_assigner(association, facade, record).assign
      end
    end

    def record
      @record ||= reflections.base_class.new(inherent_attributes)
    end

    def reflections_builder
      LayeredImport::ReflectionsBuilder.new(kind)
    end

    def reflections
      @reflections ||= reflections_builder.build_delegated_reflection
    end
  end
end
