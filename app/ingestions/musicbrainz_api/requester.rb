module MusicbrainzApi
  class Requester
    def initialize(api, import_order, uri_builder)
      @api = api
      @import_order = import_order
      @uri_builder = uri_builder
    end

    def get(...)
      uri = build_uri(...)
      api.get(uri)
    end

    private

    attr_reader :api, :import_order, :uri_builder

    def build_uri(...) = uri_builder.build(...)
  end
end
