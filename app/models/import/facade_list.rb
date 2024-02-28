module Import
  class FacadeList
    include Enumerable

    def initialize(session, data:, model:)
      @session = session
      @data = data
      @model = model
    end

    attr_reader :data, :model, :session

    def each
      data.map { |raw_data| session.build_presenter(data: raw_data, model: model) }
    end
  end
end
