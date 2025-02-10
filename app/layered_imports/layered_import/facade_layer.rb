module LayeredImport
  class FacadeLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order
    delegate :class_name_component, to: :order

    def build_facade(reflections, options)
      facade_class_for(reflections).new(self, options)
    end

    def request_layer
      @request_layer ||= order.build_request_layer
    end

    private

    def facade_class_for(reflections)
      base_class_name = reflections.base_class.name.dup # reflections.base_class.name returns a frozen string so we dup it
      ["LayeredImport::", class_name_component, base_class_name, "Facade"]
        .join
        .constantize
    end
  end
end
