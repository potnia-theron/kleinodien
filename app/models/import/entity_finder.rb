module Import
  class EntityFinder
    include Callable

    def initialize(adapter_layer, kind, options)
      @adapter_layer = adapter_layer
      @kind = kind
      @options = options
    end

    def call
      finder_class.call(order, facade)
    end

    private

    attr_reader :adapter_layer, :kind, :options
    delegate_missing_to :adapter_layer

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end

    def finder_class
      @finder_class ||= "Import::#{reflections.base_class.name}Finder".constantize
    end

    def reflections
      @reflections ||= reflections_class.new
    end

    def reflections_class
      kind
        .to_s
        .underscore
        .classify
        .then { "Import::#{it}Reflections" }
        .constantize
    end
  end
end
