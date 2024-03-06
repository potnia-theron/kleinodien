module Import
  class PersisterList
    include Enumerable

    def initialize(session, facade_list:)
      @session = session
      @facade_list = facade_list
    end

    attr_reader :facade_list, :session

    def each
      Enumerator.new do |yielder|
        facade_list.each { |item| yielder << session.build_persister(data: item, model: model) }
      end
    end
  end
end
