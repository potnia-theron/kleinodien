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

    def create_fetch_layer
      MusicbrainzFetchLayer.new(self)
    end

    def create_request_layer
      MusicbrainzRequestLayer.new(self)
    end

    def create_workflow
      ["LayeredImport::", class_name_component, "Workflow"]
        .join
        .constantize
        .new(self)
    end
  end
end
