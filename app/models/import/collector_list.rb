module Import
  class CollectorList
    include Enumerable

    def initialize(session, facade_list:)
      @session = session
      @facade_list = facade_list
    end

    attr_reader :facade_list, :session

    delegate :each, to: :collectors

    def collectors
      facade_list.map { |facade| session.build_collector(facade) }
    end

    # def each
    #   # enum = Enumerator.new do |yielder|
    #   #   facade_list.each { |item| yielder << session.build_collector(data: item, model: model) }
    #   # end
    #   # lst = facade_list.lazy.map { |item| session.build_collector(data: item, model: model) }
    #   lst = facade_list.lazy.map { |facade| session.build_collector(facade) }

    #   enum = Enumerator.new do |yielder|
    #     lst.each { |item| yielder << item }
    #   end

    #   # debugger
    #   enum.class
    #   enum
    # end

    # def each
    #   facade_list.map { |facade| session.build_collector(facade) }.each
    # end
  end
end
