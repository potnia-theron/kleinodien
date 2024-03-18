module Import
  class FacadeList
    include Enumerable

    def initialize(session, model:, **options)
      @session = session
      @options = options
      @model = model
    end

    attr_reader :model, :options, :session

    delegate :each, to: :facades

    def data
      @options[:data]
    end

    def facades
      data.map.with_index(1) { |data, consecutive_number| build_facade(data, consecutive_number) }
    end

    def to_collectors
      map do |facade|
        session.build_collector(facade)
      end
    end

    def to_persisters
      map do |facade|
        session.build_persister(facade)
      end
    end

    private

    def build_facade(data, consecutive_number)
      facade_options = options.merge({consecutive_number: consecutive_number, data: data})
      session.build_facade(model, **facade_options)
    end
  end
end
