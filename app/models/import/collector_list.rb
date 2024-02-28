module Import
  class CollectorList
    include Enumerable

    def initialize(session, facade_list:)
      @session = session
      @facade_list = facade_list
    end

    attr_reader :facade_list, :session

    def each
      facade_list.map { |facade| session.build_collector(facade) }
    end
  end
end
