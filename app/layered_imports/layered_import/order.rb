module LayeredImport
  class Order
    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

    delegate_missing_to :import_order

    def class_name_component
      type.delete_suffix("ImportOrder")
    end

    def build_fetch_layer
      join_and_constantize("LayeredImport::", class_name_component, "FetchLayer").new(self)
    end

    def build_request_layer
      join_and_constantize("LayeredImport::", class_name_component, "RequestLayer").new(self)
    end

    def build_workflow
      join_and_constantize("LayeredImport::", class_name_component, "Workflow").new(self)
    end

    private

    def join_and_constantize(*elements)
      elements.join.constantize
    end
  end
end
