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

    def create_facade_layer
      embed_class_name_component("LayeredImport::", "Facade")
        .constantize
        .new(self)
    end

    def create_request_layer
      MusicbrainzRequestLayer.new(self)
    end

    def create_workflow
      # embed_class_name_component("LayeredImport::", "Workflow")
      #   .constantize
      #   .new(self)

      # TODO: use the upper code when MusicBrainzImportOrder is renamed
      # to ->                         MusicbrainzImportOrder
      MusicbrainzWorkflow.new(self)
    end

    def embed_class_name_component(prefix, suffix)
      prefix.concat(class_name_component).concat(suffix)
    end
  end
end
