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

      assign_inherent_attributes

      record
    end

    private

    attr_reader :adapter_layer, :model, :options
    delegate_missing_to :adapter_layer

    def assign_inherent_attributes
      reflections.inherent_attribute_names.each do |attr_name|
        if (value = facade.send(attr_name))
          accessor = "#{attr_name}="
          record.send(accessor, value)
        end
      end
    end

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end

    def record
      @record ||= model.to_s.classify.constantize.new
    end

    def reflections
      @reflections ||= build_reflections_for(model)
    end
  end
end
