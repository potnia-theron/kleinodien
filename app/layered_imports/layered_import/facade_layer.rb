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
        .prepend("LayeredImport::#{order.class_name_component}")
        .concat("Facade")
        .constantize
        .new(self, options)
    end

    def request_layer
      @request_layer ||= order.create_request_layer
    end
  end
end
