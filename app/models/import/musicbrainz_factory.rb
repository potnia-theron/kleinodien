module Import
  class MusicbrainzFactory
    def initialize(session, buffer: nil)
      @buffer = buffer || Buffer.new
      @session = session
    end

    attr_reader :buffer, :session

    def build_attempt
      Import::FaradayAttempt.new(self)
    end

    def build_fetcher(uri_string)
      Import::Fetcher.new(factory: self, uri: uri_string)
    end

    def build_finder(facade)
      model_name = facade.model_class.name

      class_name = "Import::Find#{model_name}"

      klass = class_name.constantize
      klass.new(session, facade: facade)
    end

    def build_collector(facade)
      Import::Collector.new(session, facade: facade, model_class: facade.model_class)
    end

    def build_collector_list(facade_list)
      Import::CollectorList.new(session, facade_list: facade_list)
    end

    def build_facade(data:, model:)
      name = model.name
      facade_class = "Import::Musicbrainz#{name}Facade".constantize
      facade_class.new(session, data: data)
    end

    def build_facade_list(data:, model:)
      Import::FacadeList.new(session, data: data, model: model)
    end

    def build_persister(facade)
      Import::Persist.new(session, facade: facade)
    end

    def build_persister_list(facade_list)
      lst = Import::PersisterList.new(session, facade_list: facade_list)
      # debugger
      lst.class
      lst
    end

    def build_properties(model_class)
      name = model_class.name
      properties_class = "Import::#{name}Properties".constantize
      properties_class.new
    end

    def build_uri_string(kind, code)
      "https://musicbrainz.org/ws/2/#{kind}/#{code}?fmt=json"
    end

    def connection
      @connection ||= Faraday.new
    end

    def interrupter
      @interrupt ||= Import::MusicbrainzInterrupter.new
    end

    def max_tries
      config.fetch(:max_tries, 3)
    end

    def config
      @config ||= Rails.configuration.import[:musicbrainz]
    end

    def transform_response(response)
      Import::Json.parse(response.body)
    end

    private

    def build_adapter(model_class, code)
      klass = "Import::Musicbrainz#{model_class.name}Adapter".constantize
      klass.new(self, code: code)
    end
  end
end
