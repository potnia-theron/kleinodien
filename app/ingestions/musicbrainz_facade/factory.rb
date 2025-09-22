module MusicbrainzFacade
  class Factory
    def initialize(import_order, reflections_factory)
      @import_order = import_order
      @reflections_factory = reflections_factory
    end

    attr_reader :reflections_factory

    def create(desired_type, ...)
      # We use #camelize instead of #classify.
      # #classify would singularize the term.
      "#{my_module}::#{desired_type.to_s.underscore.camelize}"
        .constantize
        .new(self, ...)
    end

    def api
      @api ||= Import::MusicbrainzRequestLayer.new(import_order, fetch_layer, uri_builder)
    end

    private

    attr_reader :import_order

    def fetch_layer = Import::MusicbrainzFetchLayer.new(import_order)

    def my_module = @my_module ||= self.class.name.sub(/::.+\z/, "")

    def uri_builder = Import::MusicbrainzUriBuilder.new
  end
end
