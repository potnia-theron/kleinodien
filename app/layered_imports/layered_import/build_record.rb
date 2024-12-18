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

      attr_names = reflections.inherent_attribute_names
      # reflections.inherent_attribute_names.each do |attr|
      attr_names.each do |attr|
        if (value = facade.send(attr))
          accessor = "#{attr}="
          record.send(accessor, value)
        end
      end

      record
    end

    private

    attr_reader :adapter_layer, :model, :options
    delegate :facade_layer, to: :adapter_layer

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end

    def record
      @record ||= model.to_s.classify.constantize.new
    end

    def reflections
      @reflections ||= model
        .to_s
        .classify
        .prepend("LayeredImport::")
        .concat("Reflections")
        .constantize
    end
  end
end
