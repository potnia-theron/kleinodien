module LayeredImport
  class RecordBuilder
    include Concerns::RecordBuildable

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

    def assign_delegated_head
      head = build_delegated_head(facade, reflections)
      return unless head

      writer_name = reflections.delegated_of_association_writer

      record.send(writer_name, head)
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
