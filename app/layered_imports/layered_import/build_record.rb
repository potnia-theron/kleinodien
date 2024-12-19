module LayeredImport
  class BuildRecord
    def self.call(...)
      new(...).call
    end

    def initialize(adapter_layer, model, options)
      @adapter_layer = adapter_layer
      @model = model
      @options = options
    end

    def call
      reflections.inherent_attribute_names.index_with { |attr| facade.send(attr) }

      build_has_many_records
      assign_foreign_attributes
      record
    end

    private

    attr_reader :adapter_layer, :model, :options
    delegate_missing_to :adapter_layer

    def build_has_many_records
      LayeredImport::BuildHasManyRecords.call(adapter_layer, facade, reflections)
    end

    def inherent_attributes
      reflections.inherent_attribute_names.index_with { |attr| facade.send(attr) }.compact
    end

    def assign_foreign_attributes
      # TODO: implement #assign_foreign_attributes
      reflections.foreign_attribute_names do |attr_name|
      end
    end

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end

    def record
      @record ||= model.to_s.classify.constantize.new(inherent_attributes)
    end

    def reflections
      @reflections ||= build_reflections_for(model)
    end
  end
end
