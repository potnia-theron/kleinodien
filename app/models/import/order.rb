module Import
  class Order
    include GlobalID::Identification

    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

    delegate_missing_to :import_order

    def build_workflow = class_for("Workflow").new(self)

    def build_request_layer
      class_for("RequestLayer").new(self, build_fetch_layer, build_uri_builder)
    end

    private

    def build_fetch_layer = class_for("FetchLayer").new(self)

    def build_uri_builder = class_for("UriBuilder").new

    def class_for(suffix) = "Import::#{class_name_component}#{suffix}".constantize

    def class_name_component = @class_name_component ||= import_orderable_type.delete_suffix("ImportOrder")
  end
end
