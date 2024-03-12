module Import
  class PersisterList
    include Enumerable

    def initialize(session, facade_list:, **options)
      @session = session
      @facade_list = facade_list
      @options = options
    end

    attr_reader :facade_list, :options, :session

    delegate :each, to: :persisters

    def persisters
      facade_list.map { |facade| session.build_persister(facade, **options) }
    end
  end
end
