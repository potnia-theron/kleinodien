module Import
  class RecordBuilder
    def initialize(adapter_layer, kind, options)
      @adapter_layer = adapter_layer
      @kind = kind
      @options = options
    end

    def call
      build_has_many_records
      assign_foreign_attributes
      assign_delegated_base

      record
    end

    private

    attr_reader :adapter_layer, :kind, :options
    delegate_missing_to :adapter_layer

    def assign_foreign_attributes
      reflections.belong_to_associations.each do |association|
        adapter_layer.build_foreign_attribute_assigner(association, facade, record).assign
      end
    end

    def assign_delegated_base
      delegated_base_class = reflections.delegated_base_class
      return unless delegated_base_class

      delegated_base = build_delegated_base(facade, delegated_base_class.name)
      writer_name = reflections.delegated_of_association_writer

      record.send(writer_name, delegated_base)
    end

    def build_has_many_records
      reflections.has_many_associations.map do |association|
        build_has_many_builder(association, facade, record).build_many
      end
    end

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end

    def inherent_attributes
      names = reflections.inherent_attribute_names
      facade.scrape_many(names)
    end

    def record
      @record ||= reflections.base_class.new(inherent_attributes)
    end

    def reflections
      @reflections ||= build_reflections_for(kind)
    end
  end
end
