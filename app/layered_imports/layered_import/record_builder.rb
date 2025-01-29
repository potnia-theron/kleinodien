module LayeredImport
  class RecordBuilder
    def initialize(adapter_layer, kind, options)
      @adapter_layer = adapter_layer
      @kind = kind
      @options = options
    end

    def build_record
      build_has_many_records
      assign_foreign_attributes
      assign_delegated_head

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

    def assign_foreign_attributes
      reflections.belong_to_associations.each do |association|
        adapter_layer.create_foreign_attribute_assigner(association, facade, record).assign
      end
    end

    def assign_delegated_head
      head_class = reflections.delegated_head
      return unless head_class

      # TODO: move #build_delegated_head to AdapterLayer
      head = LayeredImport::DelegatedHeadBuilder.new(adapter_layer, facade, head_class).build_delegated_head
      writer_name = reflections.writer_on_delegated_head
      head.send(writer_name, record)
    end

    def inherent_attributes
      reflections.inherent_attribute_names.index_with { |attr| facade.send(attr) }.compact
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
