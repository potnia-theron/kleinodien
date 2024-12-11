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
    end

    private

    attr_reader :adapter_layer, :model, :options
    delegate :facade_layer, to: :adapter_layer

    def reflections
      @reflections ||= model
        .to_s
        .classify
        .prepend("LayeredImport::")
        .concat("Reflections")
        .constantize
    end

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end
  end
end
