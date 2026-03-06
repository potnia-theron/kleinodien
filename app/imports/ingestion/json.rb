module Ingestion
  class Json
    def self.parse(...) = new(...).parse

    # The second parameter (_) is optional and will be ignored.
    # It is necessary because faraday uses an empty hash as second argument.
    def initialize(json_string, _ = nil)
      @json_string = json_string
    end

    def parse = ::JSON.parse(json_string).then { transform(it) }

    private

    attr_reader :json_string

    def transform(given)
      return transform_array(given) if given.is_a? Array
      return transform_hash(given) if given.is_a? Hash

      given
    end

    def transform_array(values) = values.map { transform(it) }

    def transform_hash(hash)
      hash
        .transform_keys(&:underscore)
        .transform_keys!(&:to_sym)
        .transform_values! { transform(it) }
    end
  end
end
