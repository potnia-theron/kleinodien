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
      data.map.with_index(1) do |item, index|
        session.build_facade(model, data: item, consecutive_number: index)
      end
    end
  end
end
