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

    def build_finder(presenter)
      model_name = presenter.model.name

      class_name = "Import::Find#{model_name}"

      klass = class_name.constantize
      klass.new(presenter)
    end

    def build_collecotor(presenter)
      Import::Collector.new(presenter)
    end

    def build_preparer_list(presenter_list)
      # presenter_list.map { |presenter| build_preparer(presenter) }
      Import::CollectorList.new(session, presenter_list: presenter_list)
    end

    def build_presenter(data:, model:)
      name = model.name
      presenter_class = "Import::Musicbrainz#{name}Presenter".constantize
      presenter_class.new(session, data: data) # , model: model)
    end

    def build_presenter_list(data:, model:)
      name = model.name
      presenter_class = "Import::Musicbrainz#{name}Presenter".constantize
      Import::PresenterList.new(session, data: data, model: model)
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
