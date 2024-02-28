module Import
  class CollectorList
    include Enumerable

    def initialize(session, presenter_list:)
      @session = session
      @presenter_list = presenter_list
    end

    attr_reader :presenter_list, :session

    def each
      presenter_list.map { |presenter| session.build_collector(presenter) }
    end
  end
end
