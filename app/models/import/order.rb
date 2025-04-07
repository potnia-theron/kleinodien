module Import
  class Order
    include GlobalID::Identification

    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

    delegate_missing_to :import_order

    def build_request_layer
      join_and_constantize("Import::", class_name_component, "RequestLayer").new(self, build_fetch_layer, build_uri_builder)
    end

    def build_workflow
      join_and_constantize("Import::", class_name_component, "Workflow").new(self)
    end

    private

    def build_uri_builder
      join_and_constantize("Import::", class_name_component, "UriBuilder").new
    end

    def join_and_constantize(*elements)
      elements.join.constantize
    end

    def class_name_component
      type.delete_suffix("ImportOrder")
    end

    def build_fetch_layer
      join_and_constantize("Import::", class_name_component, "FetchLayer").new(self)
    end
  end
end
