module Import
  class FacadeList
    include Enumerable

    def initialize(session, data:, model:)
      @session = session
      @data = data
      @model = model
    end

    attr_reader :data, :model, :session

    delegate :each, to: :facades

    def facades
      # debugger
      # data.map { |item| session.build_facade(data: item, model: model) }
      data.map { |item| session.build_facade(model, data: item) }
    end
  end
end
