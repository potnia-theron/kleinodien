module Import
  class DelegatedHeadBuilder
    include Concerns::RecordBuildable

    def initialize(adapter_layer, facade, head_class)
      @adapter_layer = adapter_layer
      @facade = facade
      @head_class = head_class
    end

    def build_delegated_head
      build_has_many_records
      assign_foreign_attributes

      record
    end

    private

    attr_reader :adapter_layer, :facade, :head_class
    delegate_missing_to :adapter_layer

    def record
      @record ||= head_class.new(inherent_attributes)
    end

    def reflections
      @reflections ||= build_reflections_for(head_class)
    end
  end
end
