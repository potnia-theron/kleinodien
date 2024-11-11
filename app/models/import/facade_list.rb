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

    def buffered?
      all?(&:buffered?)
    end

    def data
      @options[:data]
    end

    def facades
      data.map.with_index(1) { |data, consecutive_number| build_facade(data, consecutive_number) }
    end

    def to_collectors(**params)
      map do |facade|
        session.build_collect_action(**params, facade: facade)
      end
    end

    def to_persisters(**params)
      map do |facade|
        session.build_create_action(**params, facade: facade)
      end
    end

    private

    def build_facade(data, consecutive_number)
      facade_options = options.merge({consecutive_number: consecutive_number})
      # delete :data from facade_options. Otherwise the :data of facade_options (an array)
      # overrides the data: keyword
      facade_options.delete(:data)

      session.build_facade(model, data: data, **facade_options)
    end
  end
end
