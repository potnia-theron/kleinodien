module LayeredImport
  class BuildRecord
    def self.call(...)
      new(...).call
    end

    def initialize(adapter_layer, kind, options)
      @adapter_layer = adapter_layer
      @kind = kind
      @options = options
    end

    def call
      build_has_many_records
      assign_foreign_attributes
      record
    end

    private

    attr_reader :adapter_layer, :kind, :options
    delegate_missing_to :adapter_layer

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

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end

    def record
      @record ||= reflections.base_class.new(inherent_attributes)
    end

    def reflections
      @reflections ||= build_reflections_for(kind)
    end
  end
end
