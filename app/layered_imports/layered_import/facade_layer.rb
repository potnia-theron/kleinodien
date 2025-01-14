module LayeredImport
  class FacadeLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order

    def build_facade(reflections, options)
      reflections
        .base_class
        .name
        .dup # reflections.base_class.name returns a frozen string so we create a new one
        # TODO: stop using "LayeredImport::Musicbrainz" as prefix for the facade-class
        .prepend("LayeredImport::Musicbrainz")
        .concat("Facade")
        .constantize
        .new(self, options)
    end

    def request_layer
      @request_layer ||= order.create_request_layer
    end
  end
end
