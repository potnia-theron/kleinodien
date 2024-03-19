module Import
  # Base class for all Import-factories
  class Factory
    def initialize(session, buffer: nil)
      @buffer = buffer || Buffer.new
      @session = session
    end

    attr_reader :buffer, :session

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
      Import::Collector.new(session, facade: facade)
    end

    def build_facade_list(model:, **)
      Import::FacadeList.new(session, model: model, **)
    end

    def build_persister(facade, **)
      Import::Persist.new(session, facade: facade, **)
    end

    def build_properties(model_class)
      name = model_class.name
      properties_class = "Import::#{name}Properties".constantize
      properties_class.new
    end
  end
end
