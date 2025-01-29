module LayeredImport
  class DelegatedHeadBuilder
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

    def inherent_attributes
      reflections.inherent_attribute_names.index_with { |attr| facade.send(attr) }.compact
    end

    def record
      @record ||= head_class.new(inherent_attributes)
    end

    def reflections
      @reflections ||= build_reflections_for(head_class)
    end
  end
end
